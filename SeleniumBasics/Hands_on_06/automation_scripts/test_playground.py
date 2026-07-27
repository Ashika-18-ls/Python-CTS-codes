import pytest
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


# -----------------------------
# Task 40 & 42
# -----------------------------
@pytest.mark.smoke
def test_simple_form_submission(driver):
    driver.get("https://www.lambdatest.com/selenium-playground/simple-form-demo")

    message_box = WebDriverWait(driver, 10).until(
        EC.presence_of_element_located((By.ID, "user-message"))
    )

    message_box.clear()
    message_box.send_keys("Hello Selenium")

    driver.find_element(
        By.XPATH,
        "//button[text()='Get Checked Value']"
    ).click()

    result = WebDriverWait(driver, 10).until(
        EC.visibility_of_element_located((By.ID, "message"))
    )

    assert result.text == "Hello Selenium"


# -----------------------------
# Task 43
# -----------------------------
@pytest.mark.regression
def test_checkbox_demo(driver):
    driver.get("https://www.lambdatest.com/selenium-playground/checkbox-demo")

    checkbox = WebDriverWait(driver, 10).until(
        EC.element_to_be_clickable(
            (By.XPATH, "(//input[@type='checkbox'])[1]")
        )
    )

    # Click checkbox
    checkbox.click()

    # Verify checkbox is selected
    assert checkbox.is_selected()

    print("Checkbox selected successfully.")