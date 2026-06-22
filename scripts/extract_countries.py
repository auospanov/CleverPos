import re
path = r"c:\Projects\CleverPos\LogicPOS.UI\Resources\Database\Data\en\databasedata.sql"
out = r"c:\Projects\CleverPos\scripts\countries_en.tsv"
with open(path, encoding="utf-8") as f:
    content = f.read()
pat = re.compile(
    r"INSERT INTO cfg_configurationcountry[^;]+"
    r"'([A-Z]{2}(?:-[A-Z]{2})?)','[A-Z0-9-]{3}','([^']*)','([^']*)'"
)
lines = []
for m in pat.finditer(content):
    lines.append(f"{m.group(1)}\t{m.group(2)}\t{m.group(3)}")
with open(out, "w", encoding="utf-8") as f:
    f.write("\n".join(lines))
print(len(lines), "countries")
