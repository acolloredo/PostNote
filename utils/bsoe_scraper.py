import requests
import re
from bs4 import BeautifulSoup
from pathlib import Path
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore


root_dir = Path(__file__).resolve().parent.parent
credentials_path = str(root_dir) + "/keys/firebaseKey.json"
cred = credentials.Certificate(credentials_path)
firebase_admin.initialize_app(cred)

db = firestore.client()


bsoe_base_url = "https://courses.engineering.ucsc.edu/"

base = requests.get(bsoe_base_url)
soup_base = BeautifulSoup(base.content, 'html.parser')
department_menu = soup_base.find("ul", id="main-menu")

department_links = []
for department in department_menu:
    if department != "\n":
        if link := department.find("a"):
            department_links.append(
                (bsoe_base_url + link["href"][1:], link.text))

department_links.pop()
print(department_links)

for link, name in department_links:
    r = requests.get(link)
    soup = BeautifulSoup(r.content, 'html.parser')
    table = soup.find("table")
    sections = table.find_all("li")

    for section in sections:
        link = section.find("a")
        section_num = link.text
        class_url = link["href"]
        class_res = re.search(
            "\/[a-z]*\/([A-Z0-9]*)\/([A-Za-z0-9]*)\/", class_url)
        class_name = class_res.group(1)
        quarter = class_res.group(2)
        full_prof = section.contents[3].strip()
        prof_res = re.search("([ a-zA-ZÀ-ž-.]*) \(|(Staff)", full_prof)
        professor_name = prof_res.group(1) or prof_res.group(2)
        docref = db.collection("classes").document()
        class_uid = docref.id

        data = {
            "department": name,
            "quarter": quarter,
            "class_name": class_name,
            "professor_name": professor_name,
            "section": section_num,
            "class_uid": class_uid
        }
        print(data)

        docref.set(data)
