import pathlib

customer_type_replacements = [
    ("'a4b3811f-9851-430d-810e-f8be7ac3f392',10,10,'Regular'", "'a4b3811f-9851-430d-810e-f8be7ac3f392',10,10,'Обычный'"),
    ("'f2a3a388-1c91-4cb6-b96c-a0a40872c53f',20,20,'Low Frequency'", "'f2a3a388-1c91-4cb6-b96c-a0a40872c53f',20,20,'Редкий'"),
    ("'e244d1bc-8ace-40f0-b275-7124188d9991',30,30,'Good'", "'e244d1bc-8ace-40f0-b275-7124188d9991',30,30,'Хороший'"),
    ("'2ea60fc9-b8d6-4e29-b322-856c898400fd',40,40,'Very Good'", "'2ea60fc9-b8d6-4e29-b322-856c898400fd',40,40,'Очень хороший'"),
    ("'ca2e73ba-5cac-4d45-860e-ccb64b061778',50,50,'Company'", "'ca2e73ba-5cac-4d45-860e-ccb64b061778',50,50,'Корпоративный'"),
    ("'15120324-9e28-4e74-8ea0-241aa9be7914',60,60,'Weekends'", "'15120324-9e28-4e74-8ea0-241aa9be7914',60,60,'Выходные'"),
]

discount_group_replacements = [
    ("'72dfb8e2-3a48-4d01-8800-8d497e599fbe',10,10,'Minimum'", "'72dfb8e2-3a48-4d01-8800-8d497e599fbe',10,10,'Минимальная'"),
    ("'cd8ecd6b-1dd8-45ae-9d81-126f65fa7e58',20,20,'Regular'", "'cd8ecd6b-1dd8-45ae-9d81-126f65fa7e58',20,20,'Обычная'"),
    ("'da3b9576-cdf8-4b18-95df-646cd70023fe',30,30,'Special'", "'da3b9576-cdf8-4b18-95df-646cd70023fe',30,30,'Специальная'"),
    ("'51880963-295b-4039-84c9-fb137975f420',40,40,'VIP'", "'51880963-295b-4039-84c9-fb137975f420',40,40,'VIP'"),
]

root = pathlib.Path(__file__).resolve().parents[1] / "LogicPOS.UI" / "Resources" / "Database" / "Data"
for path in root.rglob("ru/databasedata.sql"):
    text = path.read_text(encoding="utf-8")
    original = text
    for old, new in customer_type_replacements + discount_group_replacements:
        text = text.replace(old, new)
    if text != original:
        path.write_text(text, encoding="utf-8")
        print(f"updated {path}")
