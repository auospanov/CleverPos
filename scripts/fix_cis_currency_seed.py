# -*- coding: utf-8 -*-
"""Repair CIS currency rows corrupted by partial-regex insertion."""
import glob
import json
import os
import re

ROOT = os.path.join(os.path.dirname(__file__), "..", "LogicPOS.UI", "Resources", "Database")
CIS_PATH = os.path.join(os.path.dirname(__file__), "cis_currencies.json")

CIS_OIDS = {
    "3f8e1a2b-4c5d-6e7f-8a9b-0c1d2e3f4a5b",
    "a1b2c3d4-e5f6-4789-a012-3456789abcde",
    "b2c3d4e5-f6a7-4890-b123-456789abcdef",
    "c3d4e5f6-a7b8-4901-c234-56789abcdef0",
    "d4e5f6a7-b8c9-4012-d345-6789abcdef01",
    "e5f6a7b8-c9d0-4123-e456-789abcdef012",
    "f6a7b8c9-d0e1-4234-f567-89abcdef0123",
    "a7b8c9d0-e1f2-4345-a678-9abcdef01234",
    "b8c9d0e1-f2a3-4456-b789-abcdef012345",
    "c9d0e1f2-a3b4-4567-c89a-bcdef0123456",
    "d0e1f2a3-b4c5-4678-d9ab-cdef01234567",
    "e1f2a3b4-c5d6-4789-eabc-def012345678",
}

ZAR_STD = re.compile(
    r"^INSERT INTO cfg_configurationcurrency \(Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity\) "
    r"VALUES \('28da9212-0083-11e4-96ce-00ff2353398c', 620, 620, 'ZAR',.*\);$"
)
ZAR_ALT = re.compile(
    r"^INSERT INTO cfg_configurationcurrency \(Oid,Ord,Code,Designation,Acronym,Symbol,Entity,ExchangeRate,CreatedAt,UpdatedAt\) "
    r"VALUES \('28da9212-0083-11e4-96ce-00ff2353398c',620,620,'[^']*','ZAR',.*\);$"
)


def sql_escape(value: str) -> str:
    return value.replace("'", "''")


def detect_format(lines: list) -> str:
    for line in lines:
        if "INSERT INTO cfg_configurationcurrency (Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity)" in line:
            return "std"
        if "INSERT INTO cfg_configurationcurrency (Oid,Ord,Code,Designation,Acronym,Symbol,Entity,ExchangeRate,CreatedAt,UpdatedAt)" in line:
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
        f"'{sql_escape(designation)}', '{cur['symbol']}', '{sql_escape(entity)}');"
    )


def format_alt(cur: dict, lang: str) -> str:
    designation = cur["designation_ru"] if lang == "ru" else cur["designation_en"]
    entity = cur["entity_ru"] if lang == "ru" else cur["entity_en"]
    rate = cur["exchange_rate"]
    rate_str = f"{rate:.4f}" if cur["acronym"] == "KZT" else (str(int(rate)) if rate == int(rate) else str(rate))
    return (
        "INSERT INTO cfg_configurationcurrency (Oid,Ord,Code,Designation,Acronym,Symbol,Entity,ExchangeRate,CreatedAt,UpdatedAt) "
        f"VALUES ('{cur['oid']}',{cur['ord']},{cur['code']},'{sql_escape(designation)}','{cur['acronym']}',"
        f"'{cur['symbol']}','{sql_escape(entity)}',{rate_str},'2015-01-13 00:00:00','2015-01-13 00:00:00');"
    )


def is_cis_currency_line(line: str) -> bool:
    if "cfg_configurationcurrency" not in line:
        return False
    return any(oid in line for oid in CIS_OIDS)


def sanitize_line(line: str) -> str:
    if "'TMT'" in line and ");," in line:
        return line.split(");,")[0] + ");"
    return line


def patch_file(path: str, currencies: list) -> bool:
    with open(path, encoding="utf-8") as f:
        lines = [line.rstrip("\n") for line in f.readlines()]

    fmt = detect_format(lines)
    if not fmt:
        return False

    cleaned = []
    for line in lines:
        if is_cis_currency_line(line):
            continue
        cleaned.append(sanitize_line(line))

    lang = detect_lang(path)
    cis_lines = []
    for cur in currencies:
        cis_lines.append(format_std(cur, lang) if fmt == "std" else format_alt(cur, lang))

    zar_re = ZAR_STD if fmt == "std" else ZAR_ALT
    out = []
    inserted = False
    for line in cleaned:
        out.append(line)
        if not inserted and zar_re.match(line):
            out.extend(cis_lines)
            inserted = True

    if not inserted:
        return False

    new_content = "\n".join(out) + "\n"
    with open(path, "w", encoding="utf-8", newline="\n") as f:
        f.write(new_content)
    return True


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

    fixed = 0
    for path in sorted(set(files)):
        if patch_file(path, currencies):
            print(f"fixed {path}")
            fixed += 1

    print(f"done: {fixed} files repaired")


if __name__ == "__main__":
    main()
