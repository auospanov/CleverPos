import pathlib

replacements = [
    # Retail: места и типы обслуживания
    ("'378cef43-82a0-4c2e-a157-4907e52806ef',10,10,'Regular',1)", "'378cef43-82a0-4c2e-a157-4907e52806ef',10,10,'Обычный',1)"),
    ("'378cef43-82a0-4c2e-a157-4907e52806ef',10,10,'Regular',NULL)", "'378cef43-82a0-4c2e-a157-4907e52806ef',10,10,'Обычный',NULL)"),
    ("'9e3d68b5-5aae-459b-969d-dd039b33e8cd',20,20,'Resale',NULL)", "'9e3d68b5-5aae-459b-969d-dd039b33e8cd',20,20,'Перепродажа',NULL)"),
    ("'9e3d68b5-5aae-459b-969d-dd039b33e8cd',20,20,'Staff Consumption',NULL)", "'9e3d68b5-5aae-459b-969d-dd039b33e8cd',20,20,'Питание персонала',NULL)"),
    ("'88e92456-cea4-4a32-ad43-9c3aafb3033b',30,30,'Partner',NULL)", "'88e92456-cea4-4a32-ad43-9c3aafb3033b',30,30,'Партнёр',NULL)"),
    ("'88e92456-cea4-4a32-ad43-9c3aafb3033b',30,30,'Take-Out',1)", "'88e92456-cea4-4a32-ad43-9c3aafb3033b',30,30,'На вынос',1)"),
    ("'ab506a3c-4aec-4427-9b71-ce9f0269ce7c',40,40,'Export',1)", "'ab506a3c-4aec-4427-9b71-ce9f0269ce7c',40,40,'Экспорт',1)"),
    ("'ab506a3c-4aec-4427-9b71-ce9f0269ce7c',40,40,'Delivery',1)", "'ab506a3c-4aec-4427-9b71-ce9f0269ce7c',40,40,'Доставка',1)"),
    ("'5d1f314a-9f86-4cb8-95b7-73149a1b2ab9',10,10,'Regular',", "'5d1f314a-9f86-4cb8-95b7-73149a1b2ab9',10,10,'Обычный',"),
    ("'5d1f314a-9f86-4cb8-95b7-73149a1b2ab9',60,60,'Take-Out',", "'5d1f314a-9f86-4cb8-95b7-73149a1b2ab9',60,60,'На вынос',"),
    ("'dbb86cc4-46f5-4202-b24d-32d5b0d3f0b0',20,20,'Resale',", "'dbb86cc4-46f5-4202-b24d-32d5b0d3f0b0',20,20,'Перепродажа',"),
    ("'dbb86cc4-46f5-4202-b24d-32d5b0d3f0b0',70,70,'Delivery',", "'dbb86cc4-46f5-4202-b24d-32d5b0d3f0b0',70,70,'Доставка',"),
    ("'f8c8fa99-751e-423f-96ac-1f4fe0dcbbec',30,30,'Partner',", "'f8c8fa99-751e-423f-96ac-1f4fe0dcbbec',30,30,'Партнёр',"),
    ("'f8c8fa99-751e-423f-96ac-1f4fe0dcbbec',80,80,'Staff Area',", "'f8c8fa99-751e-423f-96ac-1f4fe0dcbbec',80,80,'Зона персонала',"),
    ("'dd5a3869-db52-42d4-bbed-dec4adfaf62b',10,10,'Bar Counter',", "'dd5a3869-db52-42d4-bbed-dec4adfaf62b',10,10,'Барная стойка',"),
    ("'99afc739-7828-4fa6-83c9-6e8b71987909',20,20,'Dinning Room',", "'99afc739-7828-4fa6-83c9-6e8b71987909',20,20,'Зал',"),
    ("'08f60493-2823-4279-920d-003ab1696eda',30,30,'Patio',", "'08f60493-2823-4279-920d-003ab1696eda',30,30,'Терраса',"),
    ("'0ae5cbc0-73de-4d28-a9b6-f415b21217d3',40,40,'Hotel',", "'0ae5cbc0-73de-4d28-a9b6-f415b21217d3',40,40,'Отель',"),
    ("'7c0dda6f-54f4-45f0-836a-71cb52aff52b',50,50,'Disco',", "'7c0dda6f-54f4-45f0-836a-71cb52aff52b',50,50,'Дискотека',"),
    # Retail: столы/заказы
    ("'Order #1'", "'Заказ №1'"),
    ("'Order #2'", "'Заказ №2'"),
    ("'Order #3'", "'Заказ №3'"),
    ("'Order #4'", "'Заказ №4'"),
    ("'Order #5'", "'Заказ №5'"),
    ("'Resale #1'", "'Перепродажа №1'"),
    ("'Resale #2'", "'Перепродажа №2'"),
    ("'Partner #1'", "'Партнёр №1'"),
    ("'Partner #2'", "'Партнёр №2'"),
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
