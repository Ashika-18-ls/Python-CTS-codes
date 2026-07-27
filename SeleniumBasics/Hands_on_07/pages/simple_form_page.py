from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


class SimpleFormPage:

    URL = "https://www.lambdatest.com/selenium-playground/simple-form-demo"

    MESSAGE_BOX = (By.ID, "user-message")
    BUTTON = (By.XPATH, "//button[text()='Get Checked Value']")
    OUTPUT = (By.ID, "message")

    def __init__(self, driver):
        self.driver = driver

    def open(self):
        self.driver.get(self.URL)

    def enter_message(self, message):
        textbox = WebDriverWait(self.driver, 10).until(
            EC.presence_of_element_located(self.MESSAGE_BOX)
        )
        textbox.clear()
        textbox.send_keys(message)

    def click_button(self):
        self.driver.find_element(*self.BUTTON).click()

    def get_message(self):
        return WebDriverWait(self.driver, 10).until(
            EC.visibility_of_element_located(self.OUTPUT)
        ).text