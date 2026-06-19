"""Phase A: KZ defaults in ru/databasedata and KZT demo prices."""
import re
import glob

ROOT = r"c:\Projects\CleverPos\LogicPOS.UI\Resources\Database"
KZT_FACTOR = 400

RU_DATABASEDATA_REPLACEMENTS = [
    ("'COMPANY_POSTALCODE','1000-280'", "'COMPANY_POSTALCODE','010000'"),
    ("'COMPANY_COUNTRY','United States'", "'COMPANY_COUNTRY','Казахстан'"),
    ("'COMPANY_COUNTRY_CODE2','US'", "'COMPANY_COUNTRY_CODE2','KZ'"),
    ("'COMPANY_FISCALNUMBER','508508509'", "'COMPANY_FISCALNUMBER','123456789012'"),
    ("'COMPANY_COUNTRY_OID','e7e8c325-a0d4-4908-b148-508ed750676a'", "'COMPANY_COUNTRY_OID','be4d3781-dfa0-40fb-ab06-1debf5bf0edd'"),
    ("'SYSTEM_CURRENCY','USD'", "'SYSTEM_CURRENCY','KZT'"),
    ("'SYSTEM_CURRENCY_OID','28dd2a3a-0083-11e4-96ce-00ff2353398c'", "'SYSTEM_CURRENCY_OID','3f8e1a2b-4c5d-6e7f-8a9b-0c1d2e3f4a5b'"),
    ("'CULTURE',NULL,'pt-PT, pt-BR, pt-MZ, pt-AO, en-GB, en-US, fr-FR, es-ES'", "'CULTURE','ru-RU','ru-RU, pt-PT, pt-BR, pt-MZ, pt-AO, en-GB, en-US, fr-FR, es-ES'"),
    ("'Конечный потребитель','999999990'", "'Конечный потребитель','000000000000'"),
    ("'0cf40622-578b-417d-b50f-e945fefb5d68',10,10,'0cf40622-578b-417d-b50f-e945fe','Конечный потребитель','000000000000',NULL,'Desconhecido','Desconhecido','1000-000','Indefinido','e7e8c325-a0d4-4908-b148-508ed750676a'",
     "'0cf40622-578b-417d-b50f-e945fefb5d68',10,10,'0cf40622-578b-417d-b50f-e945fe','Конечный потребитель','000000000000',NULL,'Не указан','Не указан','010000','Алматы','be4d3781-dfa0-40fb-ab06-1debf5bf0edd'"),
    ("'Без НДС','M99','Publication 54, 2018'", "'Без НДС','KZ01','НК РК ст. 394'"),
    ("'Sin Tax','M01','Publication 3, 2017'", "'Освобождение по НК РК','KZ02','НК РК ст. 394-407'"),
    ("'State Tax','M02','Publication 17, 2018'", "'Экспортные операции','KZ03','НК РК ст. 387'"),
    ("'County Tax','M03','Publication 17, 2018'", "'Медицинские услуги','KZ04','НК РК ст. 396'"),
    ("'City Tax','M04','Publication 17, 2018'", "'Образовательные услуги','KZ05','НК РК ст. 396'"),
    ("'Other Taxes','M05','Publication 17, 2018'", "'Финансовые услуги','KZ06','НК РК ст. 396'"),
]

# fin_article: Price1..Price5 after standard VAT OID pair
PRICE_FIELD_PATTERN = re.compile(
    r"(cee00590-7317-41b8-af46-66560401096b', 'cee00590-7317-41b8-af46-66560401096b', )"
    r"(\d+\.\d{2}), (\d+\.\d{2}), (\d+\.\d{2}), (\d+\.\d{2}), (\d+\.\d{2}), "
    r"(\d+\.\d{2}), (\d+\.\d{2}), (\d+\.\d{2}), (\d+\.\d{2}), (\d+\.\d{2}), "
)


def scale_article_prices(content: str) -> str:
    def replacer(match):
        prefix = match.group(1)
        prices = [float(match.group(i)) for i in range(2, 12)]
        scaled = []
        for i, p in enumerate(prices):
            if i < 5 and p > 0:
                scaled.append(f"{p * KZT_FACTOR:.2f}")
            else:
                scaled.append(f"{p:.2f}")
        return prefix + ", ".join(scaled) + ", "

    return PRICE_FIELD_PATTERN.sub(replacer, content)


def patch_file(path: str, is_demo: bool) -> bool:
    with open(path, encoding="utf-8") as f:
        content = f.read()
    original = content
    if not is_demo:
        for old, new in RU_DATABASEDATA_REPLACEMENTS:
            content = content.replace(old, new)
    if is_demo or "fin_article" in content:
        content = scale_article_prices(content)
    if content != original:
        with open(path, "w", encoding="utf-8", newline="\n") as f:
            f.write(content)
        return True
    return False


def main():
    ru_data = glob.glob(f"{ROOT}/Data/**/ru/databasedata.sql", recursive=True)
    ru_demos = glob.glob(f"{ROOT}/Demos/**/ru/*.sql", recursive=True)
    changed = 0
    for p in ru_data:
        if patch_file(p, False):
            print("patched", p)
            changed += 1
    for p in ru_demos:
        if patch_file(p, True):
            print("patched demo", p)
            changed += 1
    print("done", changed, "files")


if __name__ == "__main__":
    main()
