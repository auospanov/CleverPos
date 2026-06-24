import pathlib

replacements = [
    ("'ecd64d02-5249-4303-a35c-c662ffba4844',40,40,'Sin Tax'", "'ecd64d02-5249-4303-a35c-c662ffba4844',40,40,'Стандартная ставка НДС (Мадейра)'"),
    ("'f0281b91-83d7-482f-bfd8-e52461983136',50,50,'State Tax'", "'f0281b91-83d7-482f-bfd8-e52461983136',50,50,'Промежуточная ставка НДС (Мадейра)'"),
    ("'b57d85a5-843e-4b84-9660-9124006b9b05',60,60,'County Tax'", "'b57d85a5-843e-4b84-9660-9124006b9b05',60,60,'Льготная ставка НДС (Мадейра)'"),
    ("'389661c1-05f6-4830-bc06-176e2fdb3dc2',70,70,'City Tax'", "'389661c1-05f6-4830-bc06-176e2fdb3dc2',70,70,'Стандартная ставка НДС (Азорские острова)'"),
    ("'52c6ce3c-9246-4b8b-a143-b84733a074d4',80,80,'Other Taxes'", "'52c6ce3c-9246-4b8b-a143-b84733a074d4',80,80,'Промежуточная ставка НДС (Азорские острова)'"),
    ("'e4478dea-9272-4090-a71a-df775b96c4b3',90,90,'Tax Free Rate for Non-Continental Territories'", "'e4478dea-9272-4090-a71a-df775b96c4b3',90,90,'Льготная ставка НДС (внес материковые территории)'"),
    ("'PT','Continental',1)", "'PT','Материковая часть',1)"),
    ("'PT-MA','Country',1)", "'PT-MA','Мадейра',1)"),
    ("'PT-MA','State',1)", "'PT-MA','Мадейра',1)"),
    ("'PT-MA','County',1)", "'PT-MA','Мадейра',1)"),
    ("'PT-AC','City',1)", "'PT-AC','Азорские острова',1)"),
    ("'PT-AC','Non-Continental Territories',1)", "'PT-AC','Внес материковые территории',1)"),
]

root = pathlib.Path(__file__).resolve().parents[1] / "LogicPOS.UI" / "Resources" / "Database" / "Data"
for path in root.rglob("ru/databasedata.sql"):
    text = path.read_text(encoding="utf-8")
    original = text
    for old, new in replacements:
        text = text.replace(old, new)
    if text != original:
        path.write_text(text, encoding="utf-8")
        print(f"updated {path}")
