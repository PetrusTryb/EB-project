import unittest
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.expected_conditions import staleness_of
from selenium.webdriver.support.ui import WebDriverWait
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
        # TODO: zmiana na headless
        options.add_experimental_option('detach', True)
        # TODO: usunięcie obejścia blokady wklejania do konsoli
        options.add_argument('--unsafely-disable-devtools-self-xss-warnings')
        cls.browser = webdriver.Chrome(options=options)
        cls.browser.implicitly_wait(10)

    """
    Dodanie do koszyka 10 produktów (w różnych ilościach) z dwóch różnych kategorii
    """
    def test_1_add_product_to_basket(self):
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
    def test_2_search_product_by_name_and_add_random_product_to_basket(self):
        self.browser.get(PRESTASHOP_URL)
        # TODO: zmiana zapytanie po dodaniu produktów
        self.browser.find_element(by=By.NAME, value='s').send_keys('mug', Keys.ENTER)
        available_products = self.browser.find_elements(by=By.CLASS_NAME, value='product-miniature')
        selected_random = available_products[randint(0, len(available_products)-1)]
        #selected_random = available_products[1]
        selected_name = selected_random.find_element(by=By.CLASS_NAME, value='product-title').text.lower()
        print(f'Selected product: {selected_name}')
        selected_random.click()
        self.browser.find_element(by=By.CLASS_NAME, value='add-to-cart').click()
        self.browser.find_element(by=By.CLASS_NAME, value='cart-content-btn').click()
        self.assertEqual(selected_name, self.browser.find_elements(by=By.XPATH, value='//div[@class="product-line-info"]/a[@class="label"]')[-1].text.lower())
        
    """
    Usunięcie z koszyka 3 produktów
    """
    def test_3_remove_products_from_basket(self):
        self.browser.get(PRESTASHOP_URL)
        self.browser.find_element(by=By.ID, value='_desktop_cart').click()
        to_remove = self.browser.find_elements(by=By.CLASS_NAME, value='remove-from-cart')[0]
        to_remove_name = to_remove.find_element(by=By.XPATH, value='../../../../../*/*/a[@class="label"]').text.lower()
        print(f'Removing product: {to_remove_name}')
        to_remove.click()
        WebDriverWait(self.browser, 10).until(staleness_of(to_remove))
        cart_contents = self.browser.find_elements(by=By.XPATH, value='//div[@class="product-line-info"]/a[@class="label"]')
        cart_contents_names = [x.text.lower() for x in cart_contents]
        self.assertNotIn(to_remove_name, cart_contents_names)
        #self.browser.find_elements(by=By.CLASS_NAME, value='remove-from-cart')[1].click()
        # TODO: usunięcie większej ilości produktów gdy będzie to możliwe
    
    """
    Rejestracja nowego konta
    """
    def test_4_register_new_account(self):
        self.browser.find_element(by=By.ID, value='_desktop_user_info').click()
        self.browser.find_element(by=By.CLASS_NAME, value='no-account').click()
        self.browser.find_elements(by=By.NAME, value='id_gender')[randint(0, 1)].click()
        self.browser.find_element(by=By.NAME, value='firstname').send_keys('Test')
        self.browser.find_element(by=By.NAME, value='lastname').send_keys('Testowy')
        self.browser.find_element(by=By.NAME, value='email').send_keys(f'test{randint(0, 1000)}@test.com')
        self.browser.find_element(by=By.NAME, value='password').send_keys('test12345678')
        required_fields = self.browser.find_elements(by=By.CSS_SELECTOR, value='input[type=checkbox]:required')
        for field in required_fields:
            field.click()
        submit = self.browser.find_element(by=By.CSS_SELECTOR, value='button[type=submit]')
        submit.click()
        WebDriverWait(self.browser, 10).until(staleness_of(submit))
        self.assertEqual('Test Testowy', self.browser.find_element(by=By.CSS_SELECTOR, value='#_desktop_user_info > div > a.account > span').text)
    
    """
    Wykonanie zamówienia zawartości koszyka
    """
    def test_5_order_shopping_cart_content(self):
        # !!! Products with .svg graphics DISALLOW choosing ship
        
        self.browser.find_element(by=By.CSS_SELECTOR, value='#_desktop_cart > div > div > a').click()
        self.browser.find_element(by=By.CLASS_NAME, value='text-sm-center').click()
        
        self.browser.find_element(by=By.NAME, value='address1').send_keys('Gabriela Narutowicza 11/12')
        self.browser.find_element(by=By.NAME, value='postcode').send_keys('80-233')
        self.browser.find_element(by=By.NAME, value='city').send_keys('Gdańsk')
        
        self.browser.find_element(by=By.NAME, value='confirm-addresses').click()
        
    """
    Wybór jednego z dwóch* przewoźników
    * tzn. trzech: firma A, firma B, odbiór osobisty
    """
    def test_6_choose_delivery_method(self):
        # choose delivery method
        delivery_options = self.browser.find_elements(By.CSS_SELECTOR, '.delivery-option input[type="radio"]')
        random_option = randint(0, len(delivery_options)-1)
        if random_option != 0:                          # first option is clicked by default
            delivery_options[random_option].click()
        
        self.browser.find_element(by=By.NAME, value='confirmDeliveryOption').click()

    """
    Wybór metody płatności: przy odbiorze
    """
    def test_7_choose_payment_method_on_delivery(self):
        self.browser.find_element(by=By.CSS_SELECTOR, value='#payment-option-2-container input').click()
        #confirm TOS
        self.browser.find_element(by=By.NAME, value='conditions_to_approve[terms-and-conditions]').click()

    """
    Zatwierdzenie zamówienia
    """
    def test_8_place_an_order(self):
        self.browser.find_element(By.CSS_SELECTOR, '#payment-confirmation button[type="submit"]').click()
        order_confirmation = self.browser.find_element(By.CSS_SELECTOR, '#content-hook_order_confirmation').text.lower()
        
        #self.assertIn('twoje zamówienie zostało potwierdzone', order_confirmation)
        self.assertIn('your order is confirmed', order_confirmation)        # currently no PL avaliable

    """
    Sprawdzenie statusu zamówienia
    """
    def test_9_get_order_status(self):
        self.browser.get(PRESTASHOP_URL)
        self.browser.find_element(By.CLASS_NAME, 'account').click()
        # wait for page to load
        WebDriverWait(self.browser, 10).until(lambda x: x.find_element(By.ID, 'history-link'))
        self.browser.find_element(By.ID, 'history-link').click()

        order_status = self.browser.find_element(By.CSS_SELECTOR, '.table .label.label-pill.bright').text.lower()
        self.assertEqual('oczekiwanie na płatność przy odbiorze', order_status)
    
    """
    Pobranie faktury VAT
    """
        
if __name__ == '__main__':
    unittest.main(verbosity=2)
