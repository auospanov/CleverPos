import pathlib

replacements = [
    ("'f1c969b4-1022-4977-ac1a-26d3bec19c7a',0,10,10,'Generic Bar Reader'", "'f1c969b4-1022-4977-ac1a-26d3bec19c7a',0,10,10,'Универсальный сканер штрихкодов'"),
    ("'674da945-f177-4121-a538-72e8799404e6',0,20,20,'Generic Card Reader'", "'674da945-f177-4121-a538-72e8799404e6',0,20,20,'Универсальный считыватель карт'"),
    ("'f4f91d26-a66f-44be-b12b-146bde20e638',0,10,10,'Generic Scale'", "'f4f91d26-a66f-44be-b12b-146bde20e638',0,10,10,'Универсальные весы'"),
    ("'4e1ba1d6-dca8-4c04-bb63-00408b9ec467',0,20,20,'Scale DIBAL G310'", "'4e1ba1d6-dca8-4c04-bb63-00408b9ec467',0,20,20,'Весы DIBAL G310'"),
    (
        "'a8e7ecb0-1d8c-4cd5-af78-b369b22ac427',0,10,10,'Display de Cliente Genérico Appostar CPD-3230','0x03EB','0x1101','Ep01','0x10','COM1',20,60,'LogicPulse','Bem Vindo'",
        "'a8e7ecb0-1d8c-4cd5-af78-b369b22ac427',0,10,10,'Универсальный дисплей покупателя Appostar CPD-3230','0x03EB','0x1101','Ep01','0x10','COM1',20,60,'CleverPos','Добро пожаловать'",
    ),
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
