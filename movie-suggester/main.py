import requests
from bs4 import BeautifulSoup

URL = "https://www.imdb.com/chart/top/"

session=requests.Session()

response = session.get(URL)
soup = BeautifulSoup(response.text, "html.parser")

print(soup.prettify())