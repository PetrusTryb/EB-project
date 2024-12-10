import os
import requests
import jinja2
import base64
import json
from dotenv import load_dotenv
import requests.auth
from tqdm import tqdm
import bs4
import urllib3
import random
import time
from PIL import Image


class API_Client:
    def __init__(self, endpoint, api_key):
        self.endpoint = endpoint
        self.api_key = api_key
        self.session = requests.Session()
        self.session.auth = requests.auth.HTTPBasicAuth(self.api_key, '')
        urllib3.disable_warnings(category=urllib3.exceptions.InsecureRequestWarning)

    def self_check(self):
        return self.get(f'categories/').status_code == 200

    def get(self, path):
        return self.session.get(f'{self.endpoint}{path}', verify=False)

    def post(self, path, data):
        return self.session.post(f'{self.endpoint}{path}', data=data, verify=False)

    def put(self, path, data):
        return self.session.put(f'{self.endpoint}{path}', data=data, verify=False)

    def send_file(self, path, file_path):
        files = {'image': (file_path, open(file_path, 'rb'), 'image/jpeg')}
        return self.session.post(f'{self.endpoint}{path}', files=files, verify=False)


class Category:
    def __init__(self, client, name, link, parent_id):
        self.client = client
        self.name = name
        self.link = link
        self.parent_id = parent_id
        self.id = None
        self._template = jinja2.FileSystemLoader('templates').load(jinja2.Environment(), 'category.xml')

    def __str__(self):
        return f'Name: {self.name}, Link: {self.link}, Parent ID: {self.parent_id}, ID: {self.id}'

    def create(self):
        xml_data = self._template.render(name=self.name, link=self.link, id_parent=self.parent_id)
        response = self.client.post('categories/', xml_data)
        if response.status_code != 201:
            raise Exception(f'Error creating category: {response.status_code}')
        self.id = bs4.BeautifulSoup(response.text, 'xml').id.text


class Product:
    def __init__(self, client, name, description, category_id, weight, price):
        self.client = client
        self.name = name
        self.description = description
        self.category_id = category_id
        self.weight = weight
        self.price = str(round(float(price) / 1.23, 2))  # Excluding VAT
        # print(f'Price: {self.price}')
        self.id = None
        self._template = jinja2.FileSystemLoader('templates').load(jinja2.Environment(), 'product.xml')
        self._stock_template = jinja2.FileSystemLoader('templates').load(jinja2.Environment(), 'stock.xml')
        # self._price_template = jinja2.FileSystemLoader('templates').load(jinja2.Environment(), 'price.xml')

    def __str__(self):
        return f'Name: {self.name}, ID: {self.id}'

    def create(self):
        xml_data = self._template.render(
            name=self.name,
            description=self.description,
            category_id=self.category_id,
            weight=self.weight,
            price=self.price,
        )
        response = self.client.post('products/', xml_data)
        if response.status_code != 201:
            # print(xml_data)
            print("Error creating product")
            raise Exception(f'Error creating product: {response.text}')
        self.id = bs4.BeautifulSoup(response.text, 'xml').id.text

    def upload_image(self, image_path):
        response = self.client.send_file(f'images/products/{self.id}', image_path)
        if response.status_code != 200:
            raise Exception(f'Error uploading image: {response.text}')
        pass

    def change_stock(self, quantity):
        get_stock = self.client.get(f'stock_availables?filter[id_product]={self.id}&display=[id]')
        stock_id = bs4.BeautifulSoup(get_stock.text, 'xml').stock_availables.stock_available.id.text
        xml_data = self._stock_template.render(
            product_id=self.id,
            stock_id=stock_id,
            quantity=quantity
        )
        response = self.client.put(f'stock_availables/{stock_id}', xml_data)
        if response.status_code != 200:
            raise Exception(f'Error changing stock: {response.text}')


if __name__ == '__main__':
    load_dotenv()
    # Test provided Endpoint and API Key
    client = API_Client(os.getenv('PRESTASHOP_WS_ENDPOINT'), os.getenv('PRESTASHOP_WS_KEY'))
    loot_path = os.getenv('HOBBII_LOOTS_PATH')
    products_per_category = int(os.getenv('MAX_PRODUCTS_PER_CATEGORY'))
    excluded_categories = os.getenv('HOBBII_EXCLUDED_CATEGORIES').split(',')
    promo_products = os.getenv('PROMOTIONAL_PRODUCTS_HANDLES').split(',')
    promo_products_ids = []
    skip_img = os.getenv('SKIP_IMAGES') == '1'
    if not client.self_check():
        print('Error: Invalid Endpoint or API Key')
        exit(1)
    else:
        print('Self-check OK')
    # Create Categories
    loot_categories = json.loads(open(f'{loot_path}/_menu_hierarchy.json').read())
    loot_categories = [category for category in loot_categories if category['handle'] not in excluded_categories]
    top_level_categories = [category for category in loot_categories if category['parent_id'] == None]
    stored_categories = []
    for category in tqdm(top_level_categories):
        cat_name = category['readable_test']
        cat_handle = category['handle']
        category = Category(client, cat_name, cat_handle, 2)
        category.create()
        stored_categories.append(category)
    print(f'Created {len(top_level_categories)} top-level categories')
    # os._exit(1)
    # print([str(category) for category in stored_categories])
    nested_categories = [category for category in loot_categories if category['parent_id'] != None]
    for category in tqdm(nested_categories):
        if category['parent_handle'] in excluded_categories:
            continue
        cat_name = category['readable_test']
        cat_handle = category['handle']
        parent_id = [cat.id for cat in stored_categories if cat.link == category['parent_handle']][0]
        category = Category(client, cat_name, cat_handle, parent_id)
        category.create()
        stored_categories.append(category)
    print(f'Created {len(nested_categories)} nested categories')
    # Create Products for each category
    sum_created_products = 0
    products_with_two_images = 0
    image_files_dir = os.listdir(f'{loot_path}\\images')
    distinct_products = set()
    for category in stored_categories:
        category_path = f'{loot_path}\\{category.link}'
        if not os.path.exists(f'{category_path}_products.json'):
            # print(f'No products found for {category_path}')
            continue
        products = json.loads(open(f'{category_path}_products.json').read())
        products = products[:products_per_category]
        for product in tqdm(products, desc=f'Adding products for {category.name}'):
            if product['handle'] in distinct_products:
                continue
            prod = Product(
                client,
                product['title'],
                product['body_html'],
                category.id,
                product['variants'][0]['grams'],
                product['variants'][0]['price']
            )
            prod_images = []
            if not skip_img:
                for files in image_files_dir:
                    if files.startswith(f"{product['id']}_"):
                        # Check if size < 3000kB
                        file_size = os.path.getsize(f'{loot_path}\\images\\{files}')
                        if file_size > 3000000:
                            continue
                            """
                            img = Image.open(f'{loot_path}\\images\\{files}')
                            img = img.convert("P", palette=Image.ADAPTIVE, colors=256)
                            img.save(f'{loot_path}\\images\\_compressed_{files}', optimize=True, quality=10)
                            prod_images.append(f'_compressed_{files}')
                            """
                        else:
                            prod_images.append(files)
                        if len(prod_images) == 2:
                            products_with_two_images += 1
                            break
                if len(prod_images) < 2:
                    continue
            prod.create()
            product_stock = random.randint(0, 10)
            prod.change_stock(product_stock)
            if product['handle'] in promo_products:
                promo_products_ids.append(product['id'])
            for image in prod_images:
                prod.upload_image(f'{loot_path}\\images\\{image}')
            sum_created_products += 1
            distinct_products.add(product['handle'])
    print(f'Added {sum_created_products} products with two images')
    print(promo_products)
    print(promo_products_ids)