from pages.simple_form_page import SimpleFormPage


def test_simple_form(driver):

    page = SimpleFormPage(driver)

    page.open()

    page.enter_message("Hello Selenium")

    page.click_button()

    assert page.get_message() == "Hello Selenium"