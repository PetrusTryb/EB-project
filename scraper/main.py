import json
import os
import requests
import re
from tqdm import tqdm
from lxml import etree
import bs4

HIERARCHY_ONLY = True


class Scraper:
    def __init__(self, url, results_dir, pretty_print=False):
        self.url = url
        self.results_dir = results_dir
        self.pretty_print = pretty_print
        self.images_dir = os.path.join(results_dir, 'images')
        if not os.path.exists(results_dir):
            os.makedirs(results_dir)
        if not os.path.exists(self.images_dir):
            os.makedirs(self.images_dir)
        self.item_id = 0
        self.menu_hierarchy = []

    def _id(self):
        self.item_id += 1
        return self.item_id

    def get_all_collections(self):
        collections = self.get_and_save_one('collections', ['id', 'title', 'handle', 'products_count'],
                                            'collections.json')
        return collections

    def _first_level_categories(self, dom):
        top_items = dom.xpath('//*[@id="shopify-section-header"]/div[2]/div[2]/div/div/nav/ul/li')
        for item in top_items:
            try:
                handle = item.xpath('./a/@href')[0].split('/')[-1]
            except IndexError:
                handle = None
            self.menu_hierarchy.append({
                'id': self._id(),
                'parent_handle': None,
                'parent_id': None,
                'handle': handle,
                'readable_test': item.xpath('./*/*/text()')[0]
            })

    def _nested_categories(self, dom, top_items, relative_xpath):
        for i, item in enumerate(top_items):
            sub_items = dom.xpath(
                f'//*[@id="shopify-section-header"]/div[2]/div[2]/div/div/nav/ul/li[{1 + i}]/{relative_xpath}')
            for sub_item in sub_items:
                try:
                    handle = sub_item.xpath('./a/@href')[0].split('/')[-1]
                except IndexError:
                    handle = None
                if handle:
                    print(handle)
                    self.menu_hierarchy.append({
                        'id': self._id(),
                        'parent_handle': self.menu_hierarchy[i]['handle'],
                        'parent_id': self.menu_hierarchy[i]['id'],
                        'handle': handle,
                        'readable_test': sub_item.xpath('./*/text()')[0].strip()
                    })

    def get_menu_hierarchy(self):
        webpage = requests.get(self.url)
        soup = bs4.BeautifulSoup(webpage.text, 'html.parser')
        dom = etree.HTML(str(soup))
        self._first_level_categories(dom)
        top_items = self.menu_hierarchy
        self._nested_categories(dom, top_items, 'div/ul/li')
        self._nested_categories(dom, top_items, 'div/*/*/ul/li')
        with open(f'{self.results_dir}/_menu_hierarchy.json', 'w') as file:
            if self.pretty_print:
                file.write(json.dumps(self.menu_hierarchy, indent=2))
            else:
                file.write(json.dumps(self.menu_hierarchy))
        # save as CSV
        with open(f'{self.results_dir}/_menu_hierarchy.csv', 'w', encoding='UTF-8') as file:
            file.write('id,parent_handle,handle,human_readable_text\n')
            for item in self.menu_hierarchy:
                file.write(f"{item['id']},{item['parent_handle']},{item['handle']},{item['readable_test']}\n")

    def get_collection_products(self, collection):
        collection_handle = collection['handle']
        products_count = collection['products_count']
        endpoint = f'collections/{collection_handle}/products'
        fields = ['id', 'title', 'handle', 'body_html', 'product_type', 'vendor', 'variants', 'images', 'options']
        filename = f'{collection_handle}_products.json'
        self.get_and_save_all(endpoint, fields, filename, products_count)

    def get_and_save_all(self, endpoint, fields, filename, target_count):
        count = 0
        page = 1
        all_data = []
        while count < target_count:
            response = requests.get(f'{self.url}/{endpoint}.json?limit=250&page={page}')
            if response.status_code != 200:
                print(f'Call to {self.url}/{endpoint}.json failed with status code {response.status_code}')
                return
            response = response.json()[endpoint.split("/")[-1]]
            if len(response) == 0:
                break
            response = [{field: item[field] for field in fields} for item in response]
            all_data.extend(response)
            count += len(response)
            page += 1
        with open(f'{self.results_dir}/{filename}', 'w') as file:
            if self.pretty_print:
                file.write(json.dumps(all_data, indent=2))
            else:
                file.write(json.dumps(all_data))

    def get_and_save_one(self, endpoint, fields, filename):
        response = requests.get(f'{self.url}/{endpoint}.json?limit=250')  # limit=250 is the maximum limit
        if response.status_code != 200:
            print(f'Call to {self.url}/{endpoint}.json failed with status code {response.status_code}')
            return
        # extract only the fields we are interested in
        response = response.json()[endpoint]
        response = [{field: item[field] for field in fields} for item in response]
        # save the response to a file
        with open(f'{self.results_dir}/{filename}', 'w') as file:
            if self.pretty_print:
                file.write(json.dumps(response, indent=2))
            else:
                file.write(json.dumps(response))
        print(f'Downloaded {filename}')
        return response

    def download_images(self, product_data):
        for product in product_data:
            product_id = product['id']
            images = product.get('images', [])
            counter = 0
            for image in images:
                image_url = image.get('src', '')
                if not image_url:
                    continue
                sanitized_url = re.sub(r'\?.*$', '', image_url)
                image_filename = os.path.join(self.images_dir, f'{product_id}_{os.path.basename(sanitized_url)}')
                if counter == 2:
                    break
                try:
                    response = requests.get(f'{image_url}', stream=True)
                    if response.status_code == 200:
                        with open(image_filename, 'wb') as image_file:
                            for chunk in response.iter_content(1024):
                                image_file.write(chunk)
                        # print(f"Downloaded image: {image_filename}")
                        counter += 1
                except Exception as e:
                    print(f"Failed to download image from {image_url}: {e}")


if __name__ == '__main__':
    scraper = Scraper('https://hobbii.pl', 'results', True)
    collections = scraper.get_all_collections()
    scraper.get_menu_hierarchy()
    if not HIERARCHY_ONLY:
        with tqdm(total=len(collections)) as bar:
            for collection in collections:
                scraper.get_collection_products(collection)
                # Load product data from the saved file
                products_file = os.path.join('results', f"{collection['handle']}_products.json")
                with open(products_file, 'r') as file:
                    products = json.load(file)
                scraper.download_images(products)
                print(f"Downloaded images for collection: {collection['title']}")
                bar.update(1)
            bar.close()
