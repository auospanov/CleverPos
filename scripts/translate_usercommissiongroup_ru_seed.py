import pathlib

replacements = [
    # Retail
    ("'8dd94fe3-e124-4a86-b112-81d184672a58',10,10,'Store Counter'", "'8dd94fe3-e124-4a86-b112-81d184672a58',10,10,'Прилавок'"),
    ("'4a18e3a7-5152-4c21-a3bc-93efbb24c34e',20,20,'Sales'", "'4a18e3a7-5152-4c21-a3bc-93efbb24c34e',20,20,'Продавец'"),
    # Restaurant / default theme
    ("'8dd94fe3-e124-4a86-b112-81d184672a58',10,10,'Bar Corner'", "'8dd94fe3-e124-4a86-b112-81d184672a58',10,10,'Барная стойка'"),
    ("'4a18e3a7-5152-4c21-a3bc-93efbb24c34e',20,20,'Waiter'", "'4a18e3a7-5152-4c21-a3bc-93efbb24c34e',20,20,'Официант'"),
    ("'1490a7b8-5092-4084-ab96-6c8efca8f5b8',30,30,'Head Waiter'", "'1490a7b8-5092-4084-ab96-6c8efca8f5b8',30,30,'Старший официант'"),
    ("'2231a819-aeef-43e9-90a9-546d30ca90a3',50,50,'Chef'", "'2231a819-aeef-43e9-90a9-546d30ca90a3',50,50,'Шеф-повар'"),
    ("'cca989d4-d62f-4c08-95e7-117b41c4d090',60,60,'Cook'", "'cca989d4-d62f-4c08-95e7-117b41c4d090',60,60,'Повар'"),
    # BackOffice mode
    ("'8dd94fe3-e124-4a86-b112-81d184672a58',10,10,'User'", "'8dd94fe3-e124-4a86-b112-81d184672a58',10,10,'Пользователь'"),
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
