# -*- coding: utf-8 -*-
"""Translate cfg_configurationcurrency Designation/Entity in ru/databasedata.sql files."""
import glob
import json
import os
import re

ROOT = os.path.join(os.path.dirname(__file__), "..", "LogicPOS.UI", "Resources", "Database")
DICT_PATH = os.path.join(os.path.dirname(__file__), "currencies_ru.json")
CIS_PATH = os.path.join(os.path.dirname(__file__), "cis_currencies.json")

CURRENCY_STD = re.compile(
    r"^(INSERT INTO cfg_configurationcurrency \(Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity\) "
    r"VALUES \()"
    r"'([^']+)',\s*(\d+),\s*(\d+),\s*'([^']+)',\s*([^,]+),\s*'([^']*)',\s*'([^']*)',\s*'([^']*)'\);$"
)

CURRENCY_ALT = re.compile(
    r"^(INSERT INTO cfg_configurationcurrency \(Oid,Ord,Code,Designation,Acronym,Symbol,Entity,ExchangeRate,CreatedAt,UpdatedAt\) "
    r"VALUES \()"
    r"'([^']+)',(\d+),(\d+),'([^']*)','([^']*)',('[^']*'|NULL),'([^']*)',([^,]+),'([^']+)','([^']+)'\);$"
)


def sql_escape(value: str) -> str:
    return value.replace("'", "''")


def translate_std(line: str, translations: dict) -> str:
    m = CURRENCY_STD.match(line.rstrip("\n"))
    if not m:
        return line

    prefix = m.group(1)
    oid = m.group(2)
    ord_val = m.group(3)
    code = m.group(4)
    acronym = m.group(5)
    rate = m.group(6)
    symbol = m.group(8)
    entity = m.group(9)

    if acronym not in translations:
        raise KeyError(f"Missing Russian translation for Acronym={acronym}")

    designation, ru_entity = translations[acronym]
    return (
        f"{prefix}'{oid}', {ord_val}, {code}, '{acronym}', {rate}, "
        f"'{sql_escape(designation)}', '{symbol}', '{sql_escape(ru_entity)}');\n"
    )


def translate_alt(line: str, translations: dict) -> str:
    m = CURRENCY_ALT.match(line.rstrip("\n"))
    if not m:
        return line

    prefix = m.group(1)
    oid = m.group(2)
    ord_val = m.group(3)
    code = m.group(4)
    acronym = m.group(6)
    symbol = m.group(7)
    rate = m.group(9)
    created = m.group(10)
    updated = m.group(11)

    if acronym not in translations:
        raise KeyError(f"Missing Russian translation for Acronym={acronym}")

    designation, ru_entity = translations[acronym]
    return (
        f"{prefix}'{oid}',{ord_val},{code},'{sql_escape(designation)}','{acronym}',"
        f"{symbol},'{sql_escape(ru_entity)}',{rate},'{created}','{updated}');\n"
    )


def patch_file(path: str, translations: dict) -> int:
    with open(path, encoding="utf-8") as f:
        lines = f.readlines()

    changed = 0
    out = []
    for line in lines:
        if line.startswith("INSERT INTO cfg_configurationcurrency (Oid, Ord, Code, Acronym"):
            new_line = translate_std(line, translations)
        elif line.startswith("INSERT INTO cfg_configurationcurrency (Oid,Ord,Code,Designation,Acronym"):
            new_line = translate_alt(line, translations)
        else:
            out.append(line)
            continue

        if new_line != line:
            changed += 1
        out.append(new_line)

    if changed:
        with open(path, "w", encoding="utf-8", newline="\n") as f:
            f.writelines(out)
    return changed


def generate_update_sql(translations: dict, cis_currencies: list, out_path: str) -> None:
    lines = [
        "-- Update currency names to Russian (run once on existing logicposdb.db)",
        "-- Safe to re-run: inserts missing CIS currencies, then sets Designation/Entity by Acronym",
        "",
    ]
    for cur in cis_currencies:
        designation = cur["designation_ru"]
        entity = cur["entity_ru"]
        rate = f"{cur['exchange_rate']:.4f}"
        lines.append(
            "INSERT INTO cfg_configurationcurrency (Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity)"
        )
        lines.append(
            f"SELECT '{cur['oid']}', {cur['ord']}, {cur['code']}, '{cur['acronym']}', {rate}, "
            f"'{sql_escape(designation)}', '{cur['symbol']}', '{sql_escape(entity)}' "
            f"WHERE NOT EXISTS (SELECT 1 FROM cfg_configurationcurrency WHERE Acronym = '{cur['acronym']}');"
        )
        lines.append("")
    for acronym in sorted(translations.keys()):
        designation, entity = translations[acronym]
        lines.append(
            "UPDATE cfg_configurationcurrency SET "
            f"Designation = '{sql_escape(designation)}', Entity = '{sql_escape(entity)}' "
            f"WHERE Acronym = '{acronym}';"
        )
    lines.append("")
    lines.append(
        "UPDATE cfg_configurationcurrency SET Ord = 5, Code = 5 "
        "WHERE Acronym = 'KZT';"
    )
    lines.append("")
    lines.append(
        "UPDATE cfg_configurationcurrency SET Disabled = NULL, DeletedAt = NULL "
        "WHERE Acronym IN ('KZT','RUB','UAH','BYN','KGS','TJS','UZS','AMD','AZN','GEL','MDL','TMT');"
    )
    lines.append("")
    lines.append(
        "UPDATE cfg_configurationcurrency SET Designation = '-- Выберите --' "
        "WHERE Oid = '00000000-0000-0000-0000-000000000001';"
    )
    lines.append("")
    os.makedirs(os.path.dirname(out_path), exist_ok=True)
    with open(out_path, "w", encoding="utf-8", newline="\n") as f:
        f.write("\n".join(lines))


def main():
    with open(DICT_PATH, encoding="utf-8") as f:
        translations = json.load(f)
    with open(CIS_PATH, encoding="utf-8") as f:
        cis_currencies = json.load(f)

    ru_files = glob.glob(os.path.join(ROOT, "Data", "**", "ru", "databasedata.sql"), recursive=True)
    total = 0
    for path in sorted(ru_files):
        n = patch_file(path, translations)
        if n:
            print(f"patched {n} currencies in {path}")
            total += n

    update_sql = os.path.join(ROOT, "Other", "Common", "configurationcurrency_ru.sql")
    generate_update_sql(translations, cis_currencies, update_sql)
    print(f"written {update_sql}")
    print(f"done: {total} currency rows updated across {len(ru_files)} ru seed files")


if __name__ == "__main__":
    main()
