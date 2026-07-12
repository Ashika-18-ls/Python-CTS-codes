from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager
from selenium.common.exceptions import NoSuchElementException

# Chrome Options
options = Options()
# options.add_argument("--headless=new")   # Uncomment if you want headless mode

# Launch Chrome
service = Service(ChromeDriverManager().install())
driver = webdriver.Chrome(service=service, options=options)

# Maximize browser
driver.maximize_window()

# Implicit Wait
driver.implicitly_wait(10)

# Open Selenium Playground
driver.get("https://www.lambdatest.com/selenium-playground/")

# Open Simple Form Demo
driver.find_element(By.LINK_TEXT, "Simple Form Demo").click()

print("\n========== TASK 32 ==========\n")

# 1. ID Locator
driver.find_element(By.ID, "user-message")
print("✔ ID Locator Works")

# 2. NAME Locator
# The current version of the website does not have a 'name' attribute
print("❌ NAME Locator cannot be demonstrated (name attribute not available).")

# 3. CLASS NAME Locator
driver.find_element(By.CLASS_NAME, "border")
print("✔ Class Name Locator Works")

# 4. TAG NAME Locator
driver.find_element(By.TAG_NAME, "input")
print("✔ Tag Name Locator Works")

# 5. Relative XPath Locator
driver.find_element(By.XPATH, "//input[@id='user-message']")
print("✔ Relative XPath Locator Works")

# 6. CSS Selector Locator
driver.find_element(By.CSS_SELECTOR, "#user-message")
print("✔ CSS Selector Locator Works")

print("\nTask 32 Completed Successfully!")

print("\n========== TASK 33 ==========\n")

# CSS Selector by ID
driver.find_element(By.CSS_SELECTOR, "#user-message")
print("✔ CSS Selector by ID Works")

# CSS Selector by Attribute
driver.find_element(
    By.CSS_SELECTOR,
    "input[placeholder='Please enter your Message']"
)
print("✔ CSS Selector by Attribute Works")

# CSS Selector by Class
driver.find_element(
    By.CSS_SELECTOR,
    ".border"
)
print("✔ CSS Selector by Class Works")

print("\nTask 33 Completed Successfully!")

print("\n========== TASK 34 ==========\n")

# contains()
driver.find_element(
    By.XPATH,
    "//input[contains(@id,'user')]"
)
print("✔ contains() Works")

# starts-with()
driver.find_element(
    By.XPATH,
    "//input[starts-with(@id,'user')]"
)
print("✔ starts-with() Works")

# text()
driver.find_element(
    By.XPATH,
    "//button[text()='Get Checked Value']"
)
print("✔ text() Works")

print("\nTask 34 Completed Successfully!")

print("\n========== TASK 35 ==========\n")

from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

# Wait for message textbox
message_box = WebDriverWait(driver,10).until(
    EC.presence_of_element_located((By.ID,"user-message"))
)

message_box.clear()
message_box.send_keys("Hello Ashika!")

# Wait until button is clickable
button = WebDriverWait(driver,10).until(
    EC.element_to_be_clickable(
        (By.XPATH,"//button[text()='Get Checked Value']")
    )
)

button.click()

# Wait until output is visible
result = WebDriverWait(driver,10).until(
    EC.visibility_of_element_located((By.ID,"message"))
)

print("Displayed Message:", result.text)

print("\nTask 35 Completed Successfully!")

print("\n========== TASK 36 ==========\n")

# Go back to the Selenium Playground home page
driver.get("https://www.lambdatest.com/selenium-playground/")

# Find all links on the page
links = driver.find_elements(By.TAG_NAME, "a")

print("Total Links Found:", len(links))

# Print the first 10 link texts
for i, link in enumerate(links[:10], start=1):
    print(f"{i}. {link.text}")

print("\nTask 36 Completed Successfully!")

print("\n========== TASK 37 ==========\n")

# Open Simple Form Demo
driver.find_element(By.LINK_TEXT, "Simple Form Demo").click()

# Wait for textbox
message_box = WebDriverWait(driver, 10).until(
    EC.presence_of_element_located((By.ID, "user-message"))
)

# Enter message
message_box.clear()
message_box.send_keys("Hello Ashika!")

# Click button
driver.find_element(By.XPATH, "//button[text()='Get Checked Value']").click()

# Get displayed message
displayed_message = WebDriverWait(driver, 10).until(
    EC.visibility_of_element_located((By.ID, "message"))
).text

# Assertion
assert displayed_message == "Hello Ashika!", "Assertion Failed!"

print("✔ Assertion Passed")
print("Displayed Message:", displayed_message)

print("\nTask 37 Completed Successfully!")

print("\n========== TASK 38 ==========\n")

try:
    driver.find_element(By.ID, "invalid-id")
    print("Element Found")
except NoSuchElementException:
    print("✔ Exception Handled Successfully!")
    print("Element with ID 'invalid-id' does not exist.")

print("\nTask 38 Completed Successfully!")

driver.quit()
