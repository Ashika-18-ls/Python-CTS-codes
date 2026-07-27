from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


class CheckboxPage:

    URL = "https://www.lambdatest.com/selenium-playground/checkbox-demo"

    CHECKBOX = (By.XPATH, "(//input[@type='checkbox'])[1]")

    def __init__(self, driver):
        self.driver = driver

    def open(self):
        self.driver.get(self.URL)

    def select_checkbox(self):
        checkbox = WebDriverWait(self.driver, 10).until(
            EC.element_to_be_clickable(self.CHECKBOX)
        )
        checkbox.click()

    def is_selected(self):
        return self.driver.find_element(*self.CHECKBOX).is_selected()