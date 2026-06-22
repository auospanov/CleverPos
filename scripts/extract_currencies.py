import re
path = r"c:\Projects\CleverPos\LogicPOS.UI\Resources\Database\Data\Retail\en\databasedata.sql"
out = r"c:\Projects\CleverPos\scripts\currencies_en.tsv"
with open(path, encoding="utf-8") as f:
    content = f.read()
pat = re.compile(
    r"INSERT INTO cfg_configurationcurrency \(Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity\) "
    r"VALUES \('([^']+)',\s*(\d+),\s*(\d+),\s*'([^']+)',\s*([^,]+),\s*'([^']*)',\s*'([^']*)',\s*'([^']*)'\);"
)
lines = []
for m in pat.finditer(content):
    lines.append("\t".join([m.group(4), m.group(6), m.group(8)]))
with open(out, "w", encoding="utf-8") as f:
    f.write("\n".join(lines))
print(len(lines))
