# -*- coding: utf-8 -*-
"""Add CIS currency rows to all databasedata.sql seed files."""
import glob
import json
import os
import re

ROOT = os.path.join(os.path.dirname(__file__), "..", "LogicPOS.UI", "Resources", "Database")
CIS_PATH = os.path.join(os.path.dirname(__file__), "cis_currencies.json")
CIS_ACRONYMS = {"KZT", "RUB", "UAH", "BYN", "KGS", "TJS", "UZS", "AMD", "AZN", "GEL", "MDL", "TMT"}


def sql_escape(value: str) -> str:
    return value.replace("'", "''")


def detect_format(content: str) -> str:
    if "INSERT INTO cfg_configurationcurrency (Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity)" in content:
        return "std"
    if "INSERT INTO cfg_configurationcurrency (Oid,Ord,Code,Designation,Acronym,Symbol,Entity,ExchangeRate,CreatedAt,UpdatedAt)" in content:
        return "alt"
    return ""


def detect_lang(path: str) -> str:
    parts = path.replace("\\", "/").split("/")
    for part in reversed(parts):
        if part in ("ru", "en", "pt", "de", "fr", "es", "ao", "mz"):
            return part
    return "en"


def format_std(cur: dict, lang: str) -> str:
    designation = cur["designation_ru"] if lang == "ru" else cur["designation_en"]
    entity = cur["entity_ru"] if lang == "ru" else cur["entity_en"]
    rate = f"{cur['exchange_rate']:.4f}"
    return (
        "INSERT INTO cfg_configurationcurrency (Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity) "
        f"VALUES ('{cur['oid']}', {cur['ord']}, {cur['code']}, '{cur['acronym']}', {rate}, "
        f"'{sql_escape(designation)}', '{cur['symbol']}', '{sql_escape(entity)}');\n"
    )


def format_alt(cur: dict, lang: str) -> str:
    designation = cur["designation_ru"] if lang == "ru" else cur["designation_en"]
    entity = cur["entity_ru"] if lang == "ru" else cur["entity_en"]
    rate = cur["exchange_rate"]
    if rate == int(rate):
        rate_str = f"{int(rate)}.0000" if cur["acronym"] == "KZT" else str(int(rate))
    else:
        rate_str = str(rate)
    symbol = f"'{cur['symbol']}'"
    return (
        "INSERT INTO cfg_configurationcurrency (Oid,Ord,Code,Designation,Acronym,Symbol,Entity,ExchangeRate,CreatedAt,UpdatedAt) "
        f"VALUES ('{cur['oid']}',{cur['ord']},{cur['code']},'{sql_escape(designation)}','{cur['acronym']}',"
        f"{symbol},'{sql_escape(entity)}',{rate_str},'2015-01-13 00:00:00','2015-01-13 00:00:00');\n"
    )


def build_insert_lines(currencies: list, fmt: str, lang: str, existing_acronyms: set) -> list:
    lines = []
    for cur in currencies:
        if cur["acronym"] in existing_acronyms:
            continue
        if fmt == "std":
            lines.append(format_std(cur, lang))
        else:
            lines.append(format_alt(cur, lang))
    return lines


def has_complete_currency_row(content: str, acronym: str) -> bool:
    """Match only finished INSERT rows (broken partial lines must not count)."""
    if acronym == "KZT":
        return "3f8e1a2b-4c5d-6e7f-8a9b-0c1d2e3f4a5b" in content and re.search(
            rf"INSERT INTO cfg_configurationcurrency[^;]*'KZT'[^;]*\);",
            content,
            re.MULTILINE | re.DOTALL,
        )
    return bool(
        re.search(
            rf"INSERT INTO cfg_configurationcurrency[^;]*'{{0}}'[^;]*\);".format(acronym),
            content,
            re.MULTILINE | re.DOTALL,
        )
    )


def existing_acronyms(content: str) -> set:
    return {a for a in CIS_ACRONYMS if has_complete_currency_row(content, a)}


def patch_file(path: str, currencies: list) -> int:
    with open(path, encoding="utf-8") as f:
        content = f.read()

    fmt = detect_format(content)
    if not fmt:
        return 0

    present = existing_acronyms(content)
    if CIS_ACRONYMS.issubset(present):
        return 0

    lang = detect_lang(path)
    new_lines = build_insert_lines(currencies, fmt, lang, present)
    if not new_lines:
        return 0

    block = "".join(new_lines).rstrip("\n")

    out_lines = []
    inserted = False
    for line in content.splitlines(keepends=True):
        stripped = line.rstrip("\n")
        if (
            not inserted
            and stripped.startswith("INSERT INTO cfg_configurationcurrency")
            and "'ZAR'" in stripped
            and stripped.endswith(");")
        ):
            out_lines.append(line)
            out_lines.append(block + "\n")
            inserted = True
            continue
        out_lines.append(line)

    if not inserted:
        return 0

    with open(path, "w", encoding="utf-8", newline="\n") as f:
        f.writelines(out_lines)
    return len(new_lines)


def main():
    with open(CIS_PATH, encoding="utf-8") as f:
        currencies = json.load(f)

    patterns = [
        os.path.join(ROOT, "Data", "**", "databasedata.sql"),
        os.path.join(ROOT, "databasedata.sql"),
    ]
    files = []
    for pattern in patterns:
        files.extend(glob.glob(pattern, recursive=True))

    total = 0
    touched = 0
    for path in sorted(set(files)):
        n = patch_file(path, currencies)
        if n:
            print(f"added {n} CIS currencies to {path}")
            total += n
            touched += 1

    print(f"done: {total} rows across {touched} files")


if __name__ == "__main__":
    main()
