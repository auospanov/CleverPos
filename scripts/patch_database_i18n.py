# -*- coding: utf-8 -*-
"""Patch databasedata.sql (KZT, KZ regex) and create ru SQL files."""
import os
import re
import shutil

BASE = r"c:\Projects\CleverPos\LogicPOS.UI\Resources\Database"
KZT_OID = "3f8e1a2b-4c5d-6e7f-8a9b-0c1d2e3f4a5b"
KZ_OID = "be4d3781-dfa0-40fb-ab06-1debf5bf0edd"

KZT_DESIGNATION = {
    "en": "Kazakhstani Tenge",
    "de": "Kasachischer Tenge",
    "es": "Tenge kazajo",
    "fr": "Tenge kazakh",
    "pt": "Tenge do Cazaquistao",
    "ao": "Tenge do Cazaquistao",
    "mz": "Tenge do Cazaquistao",
    "ru": "Казахстанский тенге",
}

RU_REPLACEMENTS = [
    ("'-- Select --'", "'-- Выберите --'"),
    ("'-- Selecione --'", "'-- Выберите --'"),
    ("'Kazakhstan'", "'Казахстан'"),
    ("'Astana'", "'Астана'"),
    ("'Kazakhstani Tenge'", "'Казахстанский тенге'"),
    ("'Counter Assistant'", "'Помощник прилавка'"),
    ("'Retail Sales Associate'", "'Продавец-консультант'"),
    ("'Cashier'", "'Кассир'"),
    ("'Restocker'", "'Кладовщик'"),
    ("'Supervisor'", "'Супервайзер'"),
    ("'Manager'", "'Менеджер'"),
    ("'Owner'", "'Владелец'"),
    ("'Final Consumer'", "'Конечный потребитель'"),
    ("'Consumidor Final'", "'Конечный потребитель'"),
    ("'Pay Cash'", "'Наличные'"),
    ("'Regular Tax Rate'", "'Стандартная ставка НДС'"),
    ("'Intermediate Tax Rate'", "'Промежуточная ставка НДС'"),
    ("'Reduced Tax Rate'", "'Льготная ставка НДС'"),
    ("'Tax Free'", "'Без НДС'"),
    ("'Warehouse 1'", "'Склад 1'"),
    ("'Credit Card'", "'Банковская карта'"),
    ("'Debit Card'", "'Дебетовая карта'"),
    ("'Cash'", "'Наличные'"),
    ("'Table'", "'Стол'"),
    ("'Orders'", "'Заказы'"),
    ("'Documents'", "'Документы'"),
    ("'Session'", "'Смена'"),
    ("'Messages'", "'Сообщения'"),
    ("'Reports'", "'Отчёты'"),
    ("'Administration'", "'Администрирование'"),
    ("'New Year''s Day'", "'Новый год'"),
    ("'Christmas'", "'Рождество'"),
    ("'Man'", "'Мужское'"),
    ("'Women'", "'Женское'"),
    ("'Child'", "'Детское'"),
    ("'Blue Coat'", "'Синее пальто'"),
    ("'Wool Coat'", "'Шерстяное пальто'"),
    ("'Coats'", "'Пальто'"),
    ("'Shoes'", "'Обувь'"),
    ("'Pants'", "'Брюки'"),
    ("'Dresses'", "'Платья'"),
]

DEMO_STORES = {
    "Bakery": "databasedatademo_bakery.sql",
    "Butchery": "databasedatademo_butchery.sql",
    "Cafe": "databasedatademo_cafe.sql",
    "ClothingStore": "databasedatademo_clothing_store.sql",
    "HardwareStore": "databasedatademo_hardware_store.sql",
    "Parking": "databasedatademo_parking.sql",
    "Restaurant": "databasedatademo_restaurant.sql",
    "SeafoodShop": "databasedatademo_seafood_shop.sql",
    "ShoeStore": "databasedatademo_shoe_store.sql",
}


def detect_lang(path: str) -> str:
    p = path.replace("/", "\\")
    if "\\ru\\" in p:
        return "ru"
    for lang in ("en", "pt", "de", "es", "fr", "ao", "mz"):
        if f"\\{lang}\\" in p or p.endswith(f"\\Data\\{lang}\\databasedata.sql"):
            return lang
    if p.endswith("\\databasedata.sql") and "\\Data\\" not in p:
        return "pt"
    return "en"


def has_kzt_currency(content: str) -> bool:
    return bool(re.search(r"cfg_configurationcurrency[^;]*'KZT'", content))


def fix_kz_country(content: str) -> str:
    old_suffix = "'^[\\w() -]+$', '^[\\w() -]+$'"
    new_suffix = "'^[0-9]{12}$', '^[0-9]{6}$'"
    lines = content.split("\n")
    out = []
    for line in lines:
        if KZ_OID in line and "'KZ','KAZ'" in line:
            line = line.replace("'^[\w() -]+$', '^[\w() -]+$'", new_suffix)
            if old_suffix.replace(" ", "") in line.replace(" ", ""):
                pass
        out.append(line)
    return "\n".join(out)


def insert_kzt(content: str, lang: str) -> str:
    if has_kzt_currency(content):
        return content
    designation = KZT_DESIGNATION.get(lang, KZT_DESIGNATION["en"])
    if "INSERT INTO cfg_configurationcurrency (Oid,Ord,Code,Designation,Acronym" in content:
        line = (
            f"INSERT INTO cfg_configurationcurrency (Oid,Ord,Code,Designation,Acronym,Symbol,Entity,ExchangeRate,CreatedAt,UpdatedAt) "
            f"VALUES ('{KZT_OID}',630,630,'{designation}','KZT','₸','Kazakhstan',520.0000,'2015-01-13 00:00:00','2015-01-13 00:00:00');\n"
        )
    else:
        line = (
            f"INSERT INTO cfg_configurationcurrency (Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity) "
            f"VALUES ('{KZT_OID}', 630, 630, 'KZT', 520.0000, '{designation}', '₸', 'Kazakhstan');\n"
        )
    zar = re.search(r"(?m)^INSERT INTO cfg_configurationcurrency[^\n]*'ZAR'[^\n]*\n", content)
    if not zar:
        raise ValueError("ZAR currency line not found")
    pos = zar.end()
    return content[:pos] + line + content[pos:]


def patch_file(path: str) -> str:
    with open(path, "r", encoding="utf-8") as f:
        content = f.read()
    lang = detect_lang(path)
    content = fix_kz_country(content)
    content = insert_kzt(content, lang)
    with open(path, "w", encoding="utf-8", newline="\n") as f:
        f.write(content)
    return lang


def apply_ru_replacements(content: str) -> str:
    for old, new in RU_REPLACEMENTS:
        content = content.replace(old, new)
    return content


def create_ru_databasedata():
    mappings = [
        (os.path.join(BASE, "Data", "Retail", "en", "databasedata.sql"),
         os.path.join(BASE, "Data", "Retail", "ru", "databasedata.sql")),
        (os.path.join(BASE, "Data", "Default", "en", "databasedata.sql"),
         os.path.join(BASE, "Data", "Default", "ru", "databasedata.sql")),
        (os.path.join(BASE, "Data", "BackOfficeMode", "en", "databasedata.sql"),
         os.path.join(BASE, "Data", "BackOfficeMode", "ru", "databasedata.sql")),
        (os.path.join(BASE, "Data", "en", "databasedata.sql"),
         os.path.join(BASE, "Data", "ru", "databasedata.sql")),
    ]
    for src, dst in mappings:
        os.makedirs(os.path.dirname(dst), exist_ok=True)
        with open(src, "r", encoding="utf-8") as f:
            content = apply_ru_replacements(f.read())
        with open(dst, "w", encoding="utf-8", newline="\n") as f:
            f.write(content)
        patch_file(dst)
        print(f"CREATED {dst}")


def create_ru_demos():
    for store, filename in DEMO_STORES.items():
        src = os.path.join(BASE, "Demos", store, "en", filename)
        dst = os.path.join(BASE, "Demos", store, "ru", filename)
        if not os.path.isfile(src):
            print(f"SKIP demo src missing: {src}")
            continue
        os.makedirs(os.path.dirname(dst), exist_ok=True)
        with open(src, "r", encoding="utf-8") as f:
            content = apply_ru_replacements(f.read())
        with open(dst, "w", encoding="utf-8", newline="\n") as f:
            f.write(content)
        print(f"CREATED {dst}")


def create_kz_country_scripts():
    kz_dir = os.path.join(BASE, "Other", "Country", "KZ")
    os.makedirs(kz_dir, exist_ok=True)

    files = {
        "configurationvatrate.sql": """-- VAT Rate Script for KZ;
UPDATE fin_configurationvatrate SET Designation = 'Standard VAT Rate (12%)', Value = 12, TaxType = 'VAT', TaxCode = 'NOR', TaxCountryRegion = 'KZ', TaxDescription = 'Kazakhstan', Disabled = NULL WHERE Oid = 'cee00590-7317-41b8-af46-66560401096b';
UPDATE fin_configurationvatrate SET Designation = 'Tax Free', Value = 0, TaxType = 'VAT', TaxCode = 'ISE', TaxCountryRegion = 'KZ', TaxDescription = 'Kazakhstan', Disabled = NULL WHERE Oid = 'e74faad7-f5c9-4206-a662-f95820014195';
UPDATE fin_configurationvatrate SET Disabled = 1 WHERE Oid IN ('f73e3b41-4967-48c6-9f9a-260abf2146e1','7e89eaed-ce56-4565-8eec-98f2e8d004a5','ecd64d02-5249-4303-a35c-c662ffba4844','f0281b91-83d7-482f-bfd8-e52461983136','b57d85a5-843e-4b84-9660-9124006b9b05','389661c1-05f6-4830-bc06-176e2fdb3dc2','52c6ce3c-9246-4b8b-a143-b84733a074d4','e4478dea-9272-4090-a71a-df775b96c4b3');
UPDATE fin_configurationvatrate SET UpdatedBy = '090c5684-52ba-4d7a-8bc3-a00320ef503d', CreatedAt = '2014-02-28 14:02:28', UpdatedAt = '2019-03-11 23:16:18';
""",
        "configurationholidays.sql": """-- KZ Holidays;

DELETE FROM cfg_configurationholidays;

INSERT INTO cfg_configurationholidays (Oid, Ord, Code, Year, Month, Day, Designation, Description, Fixed) VALUES ('a1000001-0000-4000-8000-000000000001',  10,  10, 0,  1,  1, 'New Year', 'New Year', 1);
INSERT INTO cfg_configurationholidays (Oid, Ord, Code, Year, Month, Day, Designation, Description, Fixed) VALUES ('a1000001-0000-4000-8000-000000000002',  20,  20, 0,  1,  2, 'New Year Holiday', 'New Year Holiday', 1);
INSERT INTO cfg_configurationholidays (Oid, Ord, Code, Year, Month, Day, Designation, Description, Fixed) VALUES ('a1000001-0000-4000-8000-000000000003',  30,  30, 0,  3,  8, 'International Women''s Day', 'International Women''s Day', 1);
INSERT INTO cfg_configurationholidays (Oid, Ord, Code, Year, Month, Day, Designation, Description, Fixed) VALUES ('a1000001-0000-4000-8000-000000000004',  40,  40, 0,  3, 21, 'Nauryz', 'Nauryz', 1);
INSERT INTO cfg_configurationholidays (Oid, Ord, Code, Year, Month, Day, Designation, Description, Fixed) VALUES ('a1000001-0000-4000-8000-000000000005',  50,  50, 0,  3, 22, 'Nauryz Holiday', 'Nauryz Holiday', 1);
INSERT INTO cfg_configurationholidays (Oid, Ord, Code, Year, Month, Day, Designation, Description, Fixed) VALUES ('a1000001-0000-4000-8000-000000000006',  60,  60, 0,  3, 23, 'Nauryz Holiday', 'Nauryz Holiday', 1);
INSERT INTO cfg_configurationholidays (Oid, Ord, Code, Year, Month, Day, Designation, Description, Fixed) VALUES ('a1000001-0000-4000-8000-000000000007',  70,  70, 0,  5,  1, 'Unity Day', 'Unity Day', 1);
INSERT INTO cfg_configurationholidays (Oid, Ord, Code, Year, Month, Day, Designation, Description, Fixed) VALUES ('a1000001-0000-4000-8000-000000000008',  80,  80, 0,  5,  7, 'Defender of the Fatherland Day', 'Defender of the Fatherland Day', 1);
INSERT INTO cfg_configurationholidays (Oid, Ord, Code, Year, Month, Day, Designation, Description, Fixed) VALUES ('a1000001-0000-4000-8000-000000000009',  90,  90, 0,  5,  9, 'Victory Day', 'Victory Day', 1);
INSERT INTO cfg_configurationholidays (Oid, Ord, Code, Year, Month, Day, Designation, Description, Fixed) VALUES ('a1000001-0000-4000-8000-00000000000a', 100, 100, 0,  7,  6, 'Capital City Day', 'Capital City Day', 1);
INSERT INTO cfg_configurationholidays (Oid, Ord, Code, Year, Month, Day, Designation, Description, Fixed) VALUES ('a1000001-0000-4000-8000-00000000000b', 110, 110, 0,  8, 30, 'Constitution Day', 'Constitution Day', 1);
INSERT INTO cfg_configurationholidays (Oid, Ord, Code, Year, Month, Day, Designation, Description, Fixed) VALUES ('a1000001-0000-4000-8000-00000000000c', 120, 120, 0, 10, 25, 'Republic Day', 'Republic Day', 1);
INSERT INTO cfg_configurationholidays (Oid, Ord, Code, Year, Month, Day, Designation, Description, Fixed) VALUES ('a1000001-0000-4000-8000-00000000000d', 130, 130, 0, 12, 16, 'Independence Day', 'Independence Day', 1);

UPDATE cfg_configurationholidays SET UpdatedBy = '090c5684-52ba-4d7a-8bc3-a00320ef503d', CreatedAt = '2014-02-28 14:02:28', UpdatedAt = '2019-03-11 23:16:18';
""",
        "configurationcurrency.sql": """-- Currency Script for KZ;
UPDATE cfg_configurationcurrency SET ExchangeRate = 1.0000 WHERE Acronym = 'KZT';
UPDATE cfg_configurationcurrency SET ExchangeRate = 0.0019 WHERE Acronym = 'EUR';
UPDATE cfg_configurationcurrency SET ExchangeRate = 0.0021 WHERE Acronym = 'USD';
UPDATE cfg_configurationcurrency SET ExchangeRate = 0.0016 WHERE Acronym = 'GBP';
UPDATE cfg_configurationcurrency SET ExchangeRate = 0.0120 WHERE Acronym = 'BRL';
UPDATE cfg_configurationcurrency SET ExchangeRate = 0.2000 WHERE Acronym = 'MZN';
UPDATE cfg_configurationcurrency SET ExchangeRate = 0.0032 WHERE Acronym = 'AOA';
UPDATE cfg_configurationcurrency SET UpdatedBy = '090c5684-52ba-4d7a-8bc3-a00320ef503d', CreatedAt = '2014-02-28 14:02:28', UpdatedAt = '2019-03-11 23:16:18';
""",
        "configurationprinters.sql": """-- Printers Script for KZ;
""",
        "customer.sql": f"""-- Customer Script for KZ;
UPDATE erp_customer SET Country = '{KZ_OID}' WHERE Oid = '0cf40622-578b-417d-b50f-e945fefb5d68';
""",
    }
    for name, body in files.items():
        path = os.path.join(kz_dir, name)
        with open(path, "w", encoding="utf-8", newline="\n") as f:
            f.write(body)
        print(f"CREATED {path}")


def patch_all_databasedata():
    count = 0
    for root, _, files in os.walk(BASE):
        for name in files:
            if name == "databasedata.sql":
                path = os.path.join(root, name)
                lang = patch_file(path)
                print(f"PATCHED {path} ({lang})")
                count += 1
    return count


def main():
    create_ru_databasedata()
    create_ru_demos()
    create_kz_country_scripts()
    n = patch_all_databasedata()
    # Russian country names in ru seed files + migration SQL
    import subprocess
    import sys
    script = os.path.join(os.path.dirname(__file__), "translate_countries_ru.py")
    subprocess.check_call([sys.executable, script], cwd=os.path.dirname(__file__))
    print(f"DONE. Patched {n} databasedata files.")


if __name__ == "__main__":
    main()
