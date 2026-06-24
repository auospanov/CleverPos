# -*- coding: utf-8 -*-
"""Translate ClothingStore ru demo SQL designations from EN to RU."""
import re
from pathlib import Path

BASE = Path(r"c:\projects\logicPOS\LogicPOS.UI\Resources\Database\Demos\ClothingStore")

TRANSLATIONS = {
    "-- Select --": "-- Выберите --",
    "Man": "Мужское",
    "Women": "Женское",
    "Child": "Детское",
    "Coats": "Пальто",
    "Shoes": "Обувь",
    "Pants": "Брюки",
    "Shirt": "Свитеры",
    "T-Shirts": "Футболки",
    "Short": "Шорты",
    "Acessories": "Аксессуары",
    "Accessories": "Аксессуары",
    "Dresses": "Платья",
    "Skirts": "Юбки",
    "Shirts": "Свитеры",
    "Blue Coat": "Синее пальто",
    "Wool Coat (Man)": "Шерстяное пальто (муж.)",
    "Suede Coat": "Замшевое пальто",
    "Hood Coat": "Пальто с капюшоном",
    "Winter Overcoat": "Зимнее пальто",
    "Sandals": "Сандалии",
    "Leather Shoe (Man)": "Кожаные туфли (муж.)",
    "Trainers (Man)": "Кроссовки (муж.)",
    "Slipper": "Тапочки",
    "Winter Boot": "Зимние ботинки",
    "Jeans (Man)": "Джинсы (муж.)",
    "Suit Pants": "Брюки классические",
    "Suit Pants ": "Брюки классические",
    "Wide Pants": "Широкие брюки",
    "Large Pants": "Широкие брюки",
    "Squared Pants": "Брюки в клетку",
    "Corduroy Pants (Man)": "Вельветовые брюки (муж.)",
    "Corduroy Pants (Women)": "Вельветовые брюки (жен.)",
    "Corduroy Pants (Boy)": "Вельветовые брюки (мальчик)",
    "Corduroy Pants (Girl)": "Вельветовые брюки (девочка)",
    "Corduroy Shorts": "Вельветовые шорты",
    "Sweatshorts": "Спортивные шорты",
    "Unisex Sweatpants": "Спортивные брюки (унисекс)",
    "Winter Raincoat": "Зимний плащ",
    "Knit Coat": "Вязаное пальто",
    "Padded Coat": "Стёганое пальто",
    "Dress With Frontal Pocket": "Платье с нагрудным карманом",
    "Floral Short Dress": "Короткое платье с цветами",
    "Folded Skirt": "Юбка в складку",
    "Print Skirt": "Юбка с узором",
    "Emboidered Sweatshirt": "Свитшот с вышивкой",
    "Turtleneck Shirt": "Свитер с воротником-стойкой",
    "Knit Shirt (Women)": "Вязаный свитер (жен.)",
    "Wool Shirt (Women)": "Шерстяной свитер (жен.)",
    "Jeans (Women)": "Джинсы (жен.)",
    "Leather Shoe (Women)": "Кожаные туфли (жен.)",
    "Sandals (Women)": "Сандалии (жен.)",
    "Trainers (Women)": "Кроссовки (жен.)",
    "Glaze Shoe": "Лакированные туфли",
    "Glaze Show (Girl)": "Лакированные туфли (девочка)",
    "Unisex Boot": "Унисекс ботинки",
    "Bracelet": "Браслет",
    "Wristwatch": "Наручные часы",
    "Wristwatch (Boy)": "Наручные часы (мальчик)",
    "Wirstwatch (Girl)": "Наручные часы (девочка)",
    "Sunglasses (Women)": "Солнцезащитные очки (жен.)",
    "Long Graphic Dress (Girl)": "Длинное платье с принтом (девочка)",
    "Graphic T-Shirt (Boy)": "Футболка с принтом (мальчик)",
    "Graphic T-Shirt (Girl)": "Футболка с принтом (девочка)",
    "Polyester Graphic T-Shirt (Boy)": "Полиэстеровая футболка с принтом (мальчик)",
    "Polyester Graphic T-Shirt (Girl)": "Полиэстеровая футболка с принтом (девочка)",
    "Uniex Cotton T-Shirt": "Хлопковая футболка (унисекс)",
    "Pocket And Hood Sweatshirt": "Свитшот с капюшоном и карманами",
    "Sweatpants": "Спортивные брюки",
    "Wool Shirt": "Шерстяной свитер",
    "Knit Shirt (Man)": "Вязаный свитер (муж.)",
    "Cotton Shirt": "Хлопковая рубашка",
    "High Neck Shirt": "Свитер с воротником",
    "Simple Cotton T-Shirt": "Простая хлопковая футболка",
    "Simple Poliester T-Shirt": "Простая полиэстеровая футболка",
    "Cotton Graphic T-Shirt": "Хлопковая футболка с принтом",
    "Poliester Graphic T-Shirt": "Полиэстеровая футболка с принтом",
    "T-Shirt With Print": "Футболка с рисунком",
    "Beach Shorts": "Пляжные шорты",
    "Denim Shorts": "Джинсовые шорты",
    "Linen Shorts": "Льняные шорты",
    "Training Shorts": "Спортивные шорты",
    "Leather Wallet": "Кожаный кошелёк",
    "Leather Belt": "Кожаный ремень",
    "Sunglasses": "Солнцезащитные очки",
    "Watch": "Часы",
    "Checkered Overcoat": "Пальто в клетку",
    "Zipper Coat": "Пальто на молнии",
    "Quilted Jacket": "Стёганая куртка",
    "Long Strap Dress": "Платье на бретелях",
    "Folded Dress": "Платье с складками",
    "Velvet Dress": "Бархатное платье",
    "Short Floral Dress": "Короткое платье с цветами",
    "Simple Short Dress": "Простое короткое платье",
    "Short Graphic Dress": "Короткое платье с принтом",
    "Long Graphic Dress": "Длинное платье с принтом",
    "Strap Dress": "Платье на бретелях",
    "Long Strap Dress (Woman)": "Длинное платье на бретелях",
    "Linen Skirt": "Льняная юбка",
    "Denim Skirt": "Джинсовая юбка",
    "Pleated Skirt": "Юбка в складку",
    "Pattern Skirt": "Юбка с узором",
    "Miniskirt": "Мини-юбка",
    "Knit Shirt (Woman)": "Вязаный свитер (жен.)",
    "Embroidered Sweater": "Свитер с вышивкой",
    "Cotton Sweatshirt": "Хлопковый свитшот",
    "Jeans (Woman)": "Джинсы (жен.)",
    "Leggings": "Леггинсы",
    "Checkered Pants": "Брюки в клетку",
    "High Heel": "Туфли на каблуке",
    "Sandals (Woman)": "Сандалии (жен.)",
    "Leather Shoe (Woman)": "Кожаные туфли (жен.)",
    "Trainers (Woman)": "Кроссовки (жен.)",
    "Varnish Shoe": "Лакированные туфли",
    "Bracelets": "Браслеты",
    "Necklace": "Ожерелье",
    "Ring": "Кольцо",
    "Earrings": "Серьги",
    "Winter Coat (Boy)": "Зимнее пальто (мальчик)",
    "Winter Coat (Girl)": "Зимнее пальто (девочка)",
    "Knit Coat (Boy)": "Вязаное пальто (мальчик)",
    "Knit Coat (Girl)": "Вязаное пальто (девочка)",
    "Hood Coat (Boy/Girl)": "Пальто с капюшоном (дет.)",
    "Short Dress (Girl)": "Короткое платье (девочка)",
    "Long Printed Dress": "Длинное платье с принтом",
    "Jeans (Boy)": "Джинсы (мальчик)",
    "Jeans (Girl)": "Джинсы (девочка)",
    "Training Pants (Unisex)": "Спортивные брюки (унисекс)",
    "Sandals (Girl)": "Сандалии (девочка)",
    "Trainers (Boy)": "Кроссовки (мальчик)",
    "Leather Shoe (Boy)": "Кожаные туфли (мальчик)",
    "Varnish Shoe (Girl)": "Лакированные туфли (девочка)",
    "Bracelet (Boy)": "Браслет (мальчик)",
    "Bracelet (Girl)": "Браслет (девочка)",
    "Necklace (Girl)": "Ожерелье (девочка)",
    "Watch (Boy)": "Часы (мальчик)",
    "Watch (Girl)": "Часы (девочка)",
    "Sunglasses (Boy)": "Солнцезащитные очки (мальчик)",
    "Sunglasses (Man)": "Солнцезащитные очки (муж.)",
    "Cotton T-Shirt (Unisex)": "Хлопковая футболка (унисекс)",
    "Cotton T-Shirt (Boy)": "Хлопковая футболка (мальчик)",
    "Cotton T-Shirt (Girl)": "Хлопковая футболка (девочка)",
    "Poliester T-Shirt (Boy)": "Полиэстеровая футболка (мальчик)",
    "Poliester T-Shirt (Girl)": "Полиэстеровая футболка (девочка)",
    "Printed T-Shirt (Boy)": "Футболка с принтом (мальчик)",
    "Printed T-Shirt (Girl)": "Футболка с принтом (девочка)",
    "Hood Sweatshirt": "Свитшот с капюшоном",
    "Hood Sweatshirt With Pockets": "Свитшот с капюшоном и карманами",
    "Pouch": "Поясная сумка",
    "Woman Bracelet": "Браслет (жен.)",
}


def apply_translations(content: str) -> tuple[str, list[str]]:
  missing = []
  for en, ru in sorted(TRANSLATIONS.items(), key=lambda x: -len(x[0])):
    content = content.replace(f"'{en}'", f"'{ru}'")
  en_path = BASE / "en" / "databasedatademo_clothing_store.sql"
  en_text = en_path.read_text(encoding="utf-8")
  for name in sorted(set(re.findall(r", '([A-Za-z][^']*)'", en_text))):
    if name.startswith("Assets/"):
      continue
    if name in TRANSLATIONS:
      continue
    if f"'{name}'" in content and not re.search(r"[\u0400-\u04FF]", name):
      missing.append(name)
  return content, missing


def main():
  ru_path = BASE / "ru" / "databasedatademo_clothing_store.sql"
  content = ru_path.read_text(encoding="utf-8")
  content, missing = apply_translations(content)
  ru_path.write_text(content, encoding="utf-8")
  print(f"Updated {ru_path}")
  if missing:
    print("Still untranslated:")
    for name in missing:
      print(f"  - {name}")


if __name__ == "__main__":
  main()
