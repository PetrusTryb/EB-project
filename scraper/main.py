import json
import os

import requests
from tqdm import tqdm


class Scraper:
    def __init__(self, url, results_dir, pretty_print=False):
        self.url = url
        self.results_dir = results_dir
        self.pretty_print = pretty_print
        if not os.path.exists(results_dir):
            os.makedirs(results_dir)

    def get_all_collections(self):
        collections = self.get_and_save_one('collections', ['id', 'title', 'handle', 'products_count'],
                                            'collections.json')
        return collections

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


if __name__ == '__main__':
    scraper = Scraper('https://hobbii.pl', 'results', True)
    collections = scraper.get_all_collections()
    with tqdm(total=len(collections)) as bar:
        for collection in collections:
            scraper.get_collection_products(collection)
            bar.update(1)
        bar.close()
