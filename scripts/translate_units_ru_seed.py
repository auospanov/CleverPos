import pathlib

replacements = [
    # Единицы измерения (OID + code для точности)
    ("'4c81aa20-98ec-4497-b740-165cdb5fa395',10,10,'Unit','un.')", "'4c81aa20-98ec-4497-b740-165cdb5fa395',10,10,'Штука','шт.')"),
    ("'d04d07e2-671c-4555-a177-da7634419a9b',20,20,'Kilogram','kg')", "'d04d07e2-671c-4555-a177-da7634419a9b',20,20,'Килограмм','кг')"),
    ("'4bbdb44a-c15a-4133-9eff-bbb6ce179d61',30,30,'Liter','l')", "'4bbdb44a-c15a-4133-9eff-bbb6ce179d61',30,30,'Литр','л')"),
    ("'63f94a2e-30ae-4dae-bf2e-71e7dc49b0ff',40,40,'Hour','h')", "'63f94a2e-30ae-4dae-bf2e-71e7dc49b0ff',40,40,'Час','ч')"),
    ("'d9ff39ae-58ce-4c86-a267-899b11373380',50,50,'Metro','m')", "'d9ff39ae-58ce-4c86-a267-899b11373380',50,50,'Метр','м')"),
    ("'db6bf60c-c2b2-4130-b092-fbc78ce683fd',60,60,'Square Meter','m2')", "'db6bf60c-c2b2-4130-b092-fbc78ce683fd',60,60,'Квадратный метр','м2')"),
    ("'176429e9-38f2-42ae-8cb6-32c5aa055ac4',70,70,'Cubic Meter','m3')", "'176429e9-38f2-42ae-8cb6-32c5aa055ac4',70,70,'Кубический метр','м3')"),
    # Единицы размера
    ("'18f564aa-7da5-4a1c-9091-8014638b818c',10,10,'Regular')", "'18f564aa-7da5-4a1c-9091-8014638b818c',10,10,'Обычный')"),
    ("'4d3e69a5-90dc-4918-848f-4eb7ce7a792e',20,20,'Small')", "'4d3e69a5-90dc-4918-848f-4eb7ce7a792e',20,20,'Малый')"),
    ("'016ba999-1a4d-4933-8ff1-e5945a7652a3',30,30,'Large')", "'016ba999-1a4d-4933-8ff1-e5945a7652a3',30,30,'Большой')"),
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
