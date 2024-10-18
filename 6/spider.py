from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.support.ui import Select
from selenium.webdriver.chrome.options import Options
from bs4 import BeautifulSoup
import time

search_keyword = "CAR-T"

options = Options()
# options.add_argument("--headless")
driver = webdriver.Chrome(options=options)
driver.get("https://www.nature.com/search")

# time.sleep(100)
accept_button = driver.find_element("xpath", '//button[@data-cc-action="accept"]')
accept_button.click()
time.sleep(5)
search_box = driver.find_element(By.NAME, "q")
search_box.send_keys(search_keyword)
submit_button = driver.find_element(By.TYPE, "submit")
submit_button.click()

time.sleep(100)

page_source = driver.page_source
driver.quit()
soup = BeautifulSoup(page_source, "html.parser")

articles = soup.find_all("article", class_="c-card")

with open("nature_search_results.txt", "w") as file:
    for article in articles:
        title_tag = article.find("a", class_="c-card__link u-link-inherit")
        if title_tag:
            title = title_tag.text.strip()

            link = title_tag["href"]
            full_link = f"https://www.nature.com{link}"

            file.write(f"{title} :\n{full_link}\n\n")

