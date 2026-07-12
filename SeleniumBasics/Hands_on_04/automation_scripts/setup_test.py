from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from webdriver_manager.chrome import ChromeDriverManager

# Configure Chrome to run in headless mode
options = Options()
options.add_argument("--headless=new")

# Automatically download and use the correct ChromeDriver
service = Service(ChromeDriverManager().install())

# Launch Chrome in headless mode
driver = webdriver.Chrome(
    service=service,
    options=options
)

# Implicit wait makes Selenium wait for every element lookup.
# It is generally less efficient because it applies globally.
# Explicit waits are preferred since they wait only for specific
# elements or conditions, making tests faster and more reliable.
driver.implicitly_wait(10)

# Open the website
driver.get("https://www.lambdatest.com/selenium-playground/")

# Click the Simple Form Demo link
driver.find_element(By.LINK_TEXT, "Simple Form Demo").click()

# Verify the URL
assert "simple-form-demo" in driver.current_url

print("Successfully navigated to Simple Form Demo!")

# Go back to the previous page
driver.back()

print("Returned to the Home Page!")

# Open Google in a new tab
driver.execute_script("window.open('https://www.google.com');")

# Print all window handles
print(driver.window_handles)

# Switch to Google tab
driver.switch_to.window(driver.window_handles[1])

# Print Google title
print("Google Title:", driver.title)

# Switch back to first tab
driver.switch_to.window(driver.window_handles[0])

driver.save_screenshot("playground_screenshot.png")

# Using a consistent window size ensures that the webpage
# is displayed the same way in every test run. This helps
# avoid failures caused by responsive layouts or different
# screen resolutions.
print(driver.get_window_size())
driver.set_window_size(1280, 800)
print(driver.get_window_size())

print("Returned to LambdaTest!")

driver.quit()
