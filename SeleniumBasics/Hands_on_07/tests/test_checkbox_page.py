from pages.checkbox_page import CheckboxPage


def test_checkbox(driver):

    page = CheckboxPage(driver)

    page.open()

    page.select_checkbox()

    assert page.is_selected()