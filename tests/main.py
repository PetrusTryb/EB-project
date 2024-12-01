import unittest
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from dotenv import load_dotenv
from time import sleep
from random import randint
import os

load_dotenv()
PRESTASHOP_URL = os.getenv('PRESTASHOP_URL')

class PrestashopFrontendTestCase(unittest.TestCase):
    
    @classmethod
    def setUpClass(cls):
        options = Options()
        options.add_experimental_option("detach", True)
        cls.browser = webdriver.Chrome(options=options)
        cls.browser.implicitly_wait(10)

    """
    Dodanie do koszyka 10 produktów (w różnych ilościach) z dwóch różnych kategorii
    """
    def test_add_product_to_basket(self):
        self.browser.get(PRESTASHOP_URL)
        self.browser.find_elements(by=By.CLASS_NAME, value='category')[0].click()
        self.browser.find_elements(by=By.CLASS_NAME, value='product-miniature')[0].click()
        # TODO: dodawanie RÓŻNYCH produktów
        self.browser.find_element(by=By.NAME, value='qty').send_keys(Keys.DELETE, '10')
        self.browser.find_element(by=By.CLASS_NAME, value='add-to-cart').click()
        sleep(3)
        self.assertIn(f' 10 ', self.browser.find_elements(by=By.CLASS_NAME, value='cart-products-count')[1].text)
        
    """
    Wyszukanie produktu po nazwie i dodanie do koszyka losowego produktu spośród znalezionych
    """
    def test_search_product_by_name_and_add_random_product_to_basket(self):
        self.browser.get(PRESTASHOP_URL)
        # TODO: zmiana zapytanie po dodaniu produktów
        self.browser.find_element(by=By.NAME, value='s').send_keys('the', Keys.ENTER)
        available_products = self.browser.find_elements(by=By.CLASS_NAME, value='product-miniature')
        selected_random = available_products[randint(0, len(available_products)-1)]
        selected_random.click()
        self.browser.find_element(by=By.CLASS_NAME, value='add-to-cart').click()
        sleep(3)
        
    

if __name__ == '__main__':
    unittest.main(verbosity=2)
