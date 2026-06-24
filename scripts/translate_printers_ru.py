"""Apply Russian translations for printer seed data in ru/databasedata.sql files."""
from pathlib import Path

REPLACEMENTS = [
    # Printer types
    ("'Thermal Printer / Windows'", "'Термопринтер / Windows'"),
    ("'Thermal Printer / Linux'", "'Термопринтер / Linux'"),
    ("'Thermal Printer / Linux / Windows Socket / Network'", "'Термопринтер / Linux / Сеть (Socket)'"),
    ("'Windows A4 Printer'", "'Принтер A4 Windows'"),
    ("'Linux A4 Printer'", "'Принтер A4 Linux'"),
    ("'Export to PDF File'", "'Экспорт в PDF'"),
    # Printers
    ("'A4 Printer'", "'Принтер A4'"),
    ("'Network Generic Thermal Printer'", "'Термопринтер (сеть)'"),
    ("'Windows Generic Thermal Printer'", "'Термопринтер Windows (общий)'"),
    # Templates
    ("'Print Template for Invoices'", "'Шаблон печати счетов'"),
    ("'Print Template for Invoices (slip)'", "'Шаблон печати счетов (накладной)'"),
    ("'Print Template for Receipts (simplified)'", "'Шаблон печати квитанций (упрощённый)'"),
    ("'Print Template for Receipts (model 2)'", "'Шаблон печати квитанций (модель 2)'"),
    ("'Print Template for Direct Debit Letters'", "'Шаблон печати платёжных требований'"),
    ("'Print Template for Credit Slips'", "'Шаблон печати кредит-нот'"),
    ("'Print Template for Delivery Notes'", "'Шаблон печати накладных'"),
    ("'Print Template for Transport Documents'", "'Шаблон печати транспортных документов'"),
    ("'Print Template for Management of Fixed Assets Form'", "'Шаблон движения основных средств'"),
    ("'Print Template for Guia de movimentação de Ativos Fixos Próprios'", "'Шаблон движения основных средств'"),
    ("'Print Template for Guia de Consignação'", "'Шаблон консигнации'"),
    ("'Print Template for Return Slips (model 2)'", "'Шаблон возвратных накладных (модель 2)'"),
    ("'Print Template for Return Slips (model 1)'", "'Шаблон возвратных накладных (модель 1)'"),
    ("'Print Template for Fatura de Consignação'", "'Шаблон консигнационного счёта'"),
    ("'Print Template for Bills'", "'Шаблон печати счёта стола'"),
    ("'Print Template for Orders'", "'Шаблон печати заказов'"),
    ("'Print Template for Purchase Order'", "'Шаблон печати заказа на товар'"),
    ("'End-of-Day Closing Print Template'", "'Шаблон закрытия смены'"),
    ("'Print Template for Entradas/Saidas de Numerário'", "'Шаблон внесения/изъятия наличных'"),
    ("'Print Template for Sales Slip'", "'Шаблон печати чека'"),
    ("'Print Template for Payment on Credit'", "'Шаблон оплаты в кредит'"),
    ("'Print Template for Request for Quotation/Proposal'", "'Шаблон коммерческого предложения'"),
    ("'Print Template for Proforma Invoice'", "'Шаблон проформы'"),
    ("'Modelo para impressão de Código de Barras 40*30'", "'Шаблон печати штрихкода 40×30'"),
    ("'Modelo para impressão de Código de Barras 100*50'", "'Шаблон печати штрихкода 100×50'"),
]

RU_FILES = [
    Path(r"c:\projects\logicPOS\LogicPOS.UI\Resources\Database\Data\ru\databasedata.sql"),
    Path(r"c:\projects\logicPOS\LogicPOS.UI\Resources\Database\Data\Default\ru\databasedata.sql"),
    Path(r"c:\projects\logicPOS\LogicPOS.UI\Resources\Database\Data\Retail\ru\databasedata.sql"),
    Path(r"c:\projects\logicPOS\LogicPOS.UI\Resources\Database\Data\BackOfficeMode\ru\databasedata.sql"),
]


def main():
    for path in RU_FILES:
        text = path.read_text(encoding="utf-8")
        original = text
        for old, new in REPLACEMENTS:
            text = text.replace(old, new)
        if text != original:
            path.write_text(text, encoding="utf-8")
            print(f"Updated {path}")
        else:
            print(f"No changes in {path}")


if __name__ == "__main__":
    main()
