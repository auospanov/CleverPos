# -*- coding: utf-8 -*-
"""Move KZT to Ord/Code 5 so it appears at the top of the currency list."""
import glob
import os
import re

ROOT = os.path.join(os.path.dirname(__file__), "..", "LogicPOS.UI", "Resources", "Database")

STD = re.compile(
    r"(\('3f8e1a2b-4c5d-6e7f-8a9b-0c1d2e3f4a5b', )\d+, \d+, ('KZT')"
)
ALT = re.compile(
    r"(\('3f8e1a2b-4c5d-6e7f-8a9b-0c1d2e3f4a5b',)\d+,\d+,(.*?'KZT')"
)


def patch(path: str) -> bool:
    with open(path, encoding="utf-8") as f:
        content = f.read()
    new_content = STD.sub(r"\g<1>5, 5, \2", content)
    new_content = ALT.sub(r"\g<1>5,5,\2", new_content)
    if new_content == content:
        return False
    with open(path, "w", encoding="utf-8", newline="\n") as f:
        f.write(new_content)
    return True


def main():
    patterns = [
        os.path.join(ROOT, "Data", "**", "databasedata.sql"),
        os.path.join(ROOT, "databasedata.sql"),
        os.path.join(ROOT, "Other", "Common", "configurationcurrency_ru.sql"),
    ]
    files = []
    for pattern in patterns:
        files.extend(glob.glob(pattern, recursive=True))
    n = 0
    for path in sorted(set(files)):
        if patch(path):
            print(path)
            n += 1
    print(f"updated {n} files")


if __name__ == "__main__":
    main()
