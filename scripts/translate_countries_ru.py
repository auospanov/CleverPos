# -*- coding: utf-8 -*-
"""Translate cfg_configurationcountry Designation/Capital in ru/databasedata.sql files."""
import glob
import json
import os
import re

ROOT = os.path.join(os.path.dirname(__file__), "..", "LogicPOS.UI", "Resources", "Database")
DICT_PATH = os.path.join(os.path.dirname(__file__), "countries_ru.json")

COUNTRY_INSERT = re.compile(
    r"^(INSERT INTO cfg_configurationcountry \(Oid,Ord,Code,Code2,Code3,Designation,Capital,"
    r"TLD,Currency,CurrencyCode,RegExFiscalNumber,RegExZipCode\) VALUES \()"
    r"'([^']+)',(\d+),(\d+),'([^']+)','([^']*)','([^']*)','([^']*)',"
    r"'([^']*)','([^']*)','([^']*)','([^']*)','([^']*)'\);$"
)


def sql_escape(value: str) -> str:
    return value.replace("'", "''")


def translate_line(line: str, translations: dict) -> str:
    m = COUNTRY_INSERT.match(line.rstrip("\n"))
    if not m:
        return line

    prefix = m.group(1)
    oid = m.group(2)
    ord_val = m.group(3)
    code = m.group(4)
    code2 = m.group(5)
    code3 = m.group(6)
    designation = m.group(7)
    capital = m.group(8)
    tld = m.group(9)
    currency = m.group(10)
    currency_code = m.group(11)
    regex_fiscal = m.group(12)
    regex_zip = m.group(13)

    if code2 not in translations:
        raise KeyError(f"Missing Russian translation for Code2={code2} ({designation})")

    ru_name, ru_capital = translations[code2]
    return (
        f"{prefix}'{oid}',{ord_val},{code},'{code2}','{code3}',"
        f"'{sql_escape(ru_name)}','{sql_escape(ru_capital)}',"
        f"'{tld}','{currency}','{currency_code}','{regex_fiscal}','{regex_zip}');\n"
    )


def patch_file(path: str, translations: dict) -> int:
    with open(path, encoding="utf-8") as f:
        lines = f.readlines()

    changed = 0
    out = []
    for line in lines:
        if line.startswith("INSERT INTO cfg_configurationcountry (Oid,Ord,Code,Code2"):
            new_line = translate_line(line, translations)
            if new_line != line:
                changed += 1
            out.append(new_line)
        else:
            out.append(line)

    if changed:
        with open(path, "w", encoding="utf-8", newline="\n") as f:
            f.writelines(out)
    return changed


def generate_update_sql(translations: dict, out_path: str) -> None:
    """SQL to fix countries in an existing database without recreating it."""
    lines = [
        "-- Update country names to Russian (run once on existing logicposdb.db)",
        "-- Safe to re-run: sets Designation/Capital by stable Code2",
        "",
    ]
    for code2 in sorted(translations.keys(), key=lambda c: (len(c), c)):
        name, capital = translations[code2]
        lines.append(
            "UPDATE cfg_configurationcountry SET "
            f"Designation = '{sql_escape(name)}', Capital = '{sql_escape(capital)}' "
            f"WHERE Code2 = '{code2}';"
        )
    lines.append("")
    lines.append(
        "UPDATE cfg_configurationcountry SET Designation = '-- Выберите --' "
        "WHERE Oid = '00000000-0000-0000-0000-000000000001';"
    )
    lines.append("")
    os.makedirs(os.path.dirname(out_path), exist_ok=True)
    with open(out_path, "w", encoding="utf-8", newline="\n") as f:
        f.write("\n".join(lines))


def main():
    with open(DICT_PATH, encoding="utf-8") as f:
        translations = json.load(f)

    ru_files = glob.glob(os.path.join(ROOT, "Data", "**", "ru", "databasedata.sql"), recursive=True)
    total = 0
    for path in sorted(ru_files):
        n = patch_file(path, translations)
        if n:
            print(f"patched {n} countries in {path}")
            total += n

    update_sql = os.path.join(ROOT, "Other", "Common", "configurationcountry_ru.sql")
    generate_update_sql(translations, update_sql)
    print(f"written {update_sql}")
    print(f"done: {total} country rows updated across {len(ru_files)} ru seed files")


if __name__ == "__main__":
    main()
