import glob
import os

KZ_OID = "be4d3781-dfa0-40fb-ab06-1debf5bf0edd"
OLD = r"'^[\w() -]+$','^[\w() -]+$'"
NEW = r"'^[0-9]{12}$','^[0-9]{6}$'"
base = r"c:\Projects\CleverPos\LogicPOS.UI\Resources\Database"

for path in glob.glob(os.path.join(base, "**", "databasedata.sql"), recursive=True):
    text = open(path, encoding="utf-8").read()
    if KZ_OID not in text:
        continue
    new_text = text
    for line in text.splitlines():
        if KZ_OID in line and OLD in line:
            new_text = new_text.replace(line, line.replace(OLD, NEW))
    if new_text != text:
        open(path, "w", encoding="utf-8", newline="\n").write(new_text)
        print("fixed", path)
