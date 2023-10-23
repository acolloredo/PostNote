import requests
import re
from bs4 import BeautifulSoup

bsoe_base_url = "https://courses.engineering.ucsc.edu/courses"
bsoe_cse_url = "https://courses.engineering.ucsc.edu/courses/cse/2023"

headers = {
    'User-Agent': 
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36"
}

r = requests.get(bsoe_cse_url)
soup = BeautifulSoup(r.content, 'html.parser')
table = soup.find("table")
sections = table.find_all("li")

for section in sections:
    link = section.find("a")
    class_url = link["href"]
    class_res = re.search("\/[a-z]*\/([A-Z0-9]*)\/([A-Za-z0-9]*)\/", class_url)
    class_name = class_res.group(1)
    quarter = class_res.group(2)
    full_prof = section.contents[3].strip()
    prof_res = re.search("([ a-zA-Z]*) \(|(Staff)", full_prof)
    professor_name = prof_res.group(1) or prof_res.group(2)
    print()
    print(quarter)
    print(class_name)
    print(professor_name)