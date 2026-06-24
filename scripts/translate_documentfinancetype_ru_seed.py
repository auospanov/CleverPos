import pathlib

replacements = [
    ("'7af04618-74a6-42a3-aaba-454b7076f5a6',10,10,'Invoice'", "'7af04618-74a6-42a3-aaba-454b7076f5a6',10,10,'Счет-фактура'"),
    ("'f8878cf5-0f88-4270-8a55-1fc2488d81a2',20,20,'Invoices (slip)'", "'f8878cf5-0f88-4270-8a55-1fc2488d81a2',20,20,'Счет-фактура (бланк)'"),
    ("'2c69b109-318a-4375-a573-28e5984b6503',30,30,'Receipt (simplified)'", "'2c69b109-318a-4375-a573-28e5984b6503',30,30,'Квитанция (упрощенная)'"),
    ("'09b6aa6e-dc0e-41fd-8dbe-8678a3d11cbc',40,40,'Receipt (model 2)'", "'09b6aa6e-dc0e-41fd-8dbe-8678a3d11cbc',40,40,'Квитанция'"),
    ("'3942d940-ed13-4a62-a352-97f1ce006d8a',50,50,'Direct Debit Letter'", "'3942d940-ed13-4a62-a352-97f1ce006d8a',50,50,'Поручение на списание'"),
    ("'fa924162-beed-4f2f-938d-919deafb7d47',60,60,'Credit Slip'", "'fa924162-beed-4f2f-938d-919deafb7d47',60,60,'Кредит-нота'"),
    ("'95f6a472-1b12-43aa-a215-a4b406b18924',70,70,'Delivery Note'", "'95f6a472-1b12-43aa-a215-a4b406b18924',70,70,'Товарная накладная'"),
    ("'96bcf534-0dab-48bb-a69e-166e81ae6f7b',80,80,'Transport Document'", "'96bcf534-0dab-48bb-a69e-166e81ae6f7b',80,80,'Транспортная накладная'"),
    ("'f8e96786-fed8-4143-be9e-b03c3a984a2c',90,90,'Management of Fixed Assets Form'", "'f8e96786-fed8-4143-be9e-b03c3a984a2c',90,90,'Учет основных средств'"),
    ("'63d8eb04-983c-4524-96de-979a240b362c',100,100,'Consignment Form'", "'63d8eb04-983c-4524-96de-979a240b362c',100,100,'Консигнационная накладная'"),
    ("'f03d2788-bed6-41ab-8d44-100039103e83',110,110,'Return Slip (model 1)'", "'f03d2788-bed6-41ab-8d44-100039103e83',110,110,'Возвратная накладная'"),
    ("'afed98d3-eae7-43a7-a7be-515753594c8f',120,120,'Bill'", "'afed98d3-eae7-43a7-a7be-515753594c8f',120,120,'Счет'"),
    ("'b8554d36-642a-4083-b608-8f1da35f0fec',130,130,'Consignment Invoice'", "'b8554d36-642a-4083-b608-8f1da35f0fec',130,130,'Консигнационный счет-фактура'"),
    ("'005ac531-31a1-44bb-9346-058f9c9ad01a',140,140,'Request for Quotation/Proposal'", "'005ac531-31a1-44bb-9346-058f9c9ad01a',140,140,'Запрос котировки/предложения'"),
    ("'6f4249d0-4aaf-4711-814f-7f9533a1ef7f',150,150,'Proforma Invoice'", "'6f4249d0-4aaf-4711-814f-7f9533a1ef7f',150,150,'Проформа-счет'"),
    ("'a009168d-fed1-4f52-b9e3-77e280b18ff5',160,160,'Sales Slip'", "'a009168d-fed1-4f52-b9e3-77e280b18ff5',160,160,'Товарный чек'"),
    ("'235f06f3-5ec3-4e13-977b-325614b07e35',170,170,'Payment on Credit'", "'235f06f3-5ec3-4e13-977b-325614b07e35',170,170,'Оплата в кредит'"),
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
