import pathlib

payment_condition_replacements = [
    ("'989e65f9-ea5f-47c1-8505-1c0038e9a552',20,20,'Net 10'", "'989e65f9-ea5f-47c1-8505-1c0038e9a552',20,20,'Оплата в течение 10 дней'"),
    ("'198235e4-12e3-42ad-b6fb-2675b5baeac2',30,30,'Net 15'", "'198235e4-12e3-42ad-b6fb-2675b5baeac2',30,30,'Оплата в течение 15 дней'"),
    ("'3464045c-9776-48f8-83ad-9bb741526965',40,40,'Net 30'", "'3464045c-9776-48f8-83ad-9bb741526965',40,40,'Оплата в течение 30 дней'"),
    ("'bb487817-8819-4fdd-a3ea-b302f32a4ce9',50,50,'2% 10, Net 30'", "'bb487817-8819-4fdd-a3ea-b302f32a4ce9',50,50,'Скидка 2% за 10 дней, иначе 30'"),
    ("'c07a5c41-37b2-4bf3-9469-5faf1799a89f',60,60,'Financing Payment'", "'c07a5c41-37b2-4bf3-9469-5faf1799a89f',60,60,'Оплата в рассрочку'"),
    ("'27c320aa-6c51-4a8e-94cd-c7e07a3b5d66',70,70,'Cash on Delivery'", "'27c320aa-6c51-4a8e-94cd-c7e07a3b5d66',70,70,'Оплата при доставке'"),
    ("'10007044-2ad3-47a1-812c-d3f91203e50e',80,80,'Cash with Order'", "'10007044-2ad3-47a1-812c-d3f91203e50e',80,80,'Оплата при заказе'"),
    ("'cf94d207-e4c1-4f7b-913e-eaf3df60bc88',90,90,'Cash in Advance'", "'cf94d207-e4c1-4f7b-913e-eaf3df60bc88',90,90,'Предоплата'"),
]

payment_method_replacements = [
    ("'BANK_CHECK','Bank Check'", "'BANK_CHECK','Банковский чек'"),
    ("'BANK_CHECK','Check'", "'BANK_CHECK','Банковский чек'"),
    ("'CASH_MACHINE','ATM'", "'CASH_MACHINE','Банкомат'"),
    ("'OTHER','Others'", "'OTHER','Прочее'"),
    ("'BANK_TRANSFER','Wire Transfer'", "'BANK_TRANSFER','Банковский перевод'"),
    ("'VISA','Visa Payment'", "'VISA','Оплата Visa'"),
    ("'CURRENT_ACCOUNT','Pay On Credit'", "'CURRENT_ACCOUNT','Оплата в кредит'"),
    ("'CUSTOMER_CARD','Customer Card'", "'CUSTOMER_CARD','Карта клиента'"),
]

root = pathlib.Path(__file__).resolve().parents[1] / "LogicPOS.UI" / "Resources" / "Database" / "Data"
for path in root.rglob("ru/databasedata.sql"):
    text = path.read_text(encoding="utf-8")
    original = text
    for old, new in payment_condition_replacements + payment_method_replacements:
        text = text.replace(old, new)
    if text != original:
        path.write_text(text, encoding="utf-8")
        print(f"updated {path}")
