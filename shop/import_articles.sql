-- Импорт каталога магазина из папки shop/
-- SQLite (logicposdb.db). Перед запуском: сделайте резервную копию БД.
--
-- Предварительно:
--   1. Переименуйте фото по images_mapping.csv → положите в shop/images/
--   2. Скопируйте shop/images/*.jpg в:
--      LogicPOS.UI/Assets/Images/Products/Shop/
--   3. Выполните этот скрипт (DB Browser for SQLite / sqlite3 / ручной SQL в BackOffice)
--
-- Примечание: колонка BarCode заполняется здесь; Excel-импорт BackOffice пока BarCode не пишет (задача C-1).

-- ─── Семейства (если ещё нет) ───────────────────────────────────────────────

INSERT OR IGNORE INTO fin_articlefamily (Oid, Ord, Code, Designation, Disabled, CreatedAt, UpdatedAt)
SELECT 'a1000001-0000-4000-8000-000000000001', 210, 210, 'Женское', 0, datetime('now'), datetime('now')
WHERE NOT EXISTS (SELECT 1 FROM fin_articlefamily WHERE Designation = 'Женское');

-- ─── Подсемейства (типы без цен в названии) ───────────────────────────────────

INSERT INTO fin_articlesubfamily (Oid, Ord, Code, Designation, Family, CreatedAt, UpdatedAt)
SELECT 'b1000001-0000-4000-8000-000000000001', 210, 210, 'Топ', f.Oid, datetime('now'), datetime('now')
FROM fin_articlefamily f WHERE f.Designation = 'Женское'
AND NOT EXISTS (SELECT 1 FROM fin_articlesubfamily sf WHERE sf.Family = f.Oid AND sf.Designation = 'Топ');

INSERT INTO fin_articlesubfamily (Oid, Ord, Code, Designation, Family, CreatedAt, UpdatedAt)
SELECT 'b1000002-0000-4000-8000-000000000002', 220, 220, 'Футболка', f.Oid, datetime('now'), datetime('now')
FROM fin_articlefamily f WHERE f.Designation = 'Женское'
AND NOT EXISTS (SELECT 1 FROM fin_articlesubfamily sf WHERE sf.Family = f.Oid AND sf.Designation = 'Футболка');

INSERT INTO fin_articlesubfamily (Oid, Ord, Code, Designation, Family, CreatedAt, UpdatedAt)
SELECT 'b1000003-0000-4000-8000-000000000003', 230, 230, 'Блуза', f.Oid, datetime('now'), datetime('now')
FROM fin_articlefamily f WHERE f.Designation = 'Женское'
AND NOT EXISTS (SELECT 1 FROM fin_articlesubfamily sf WHERE sf.Family = f.Oid AND sf.Designation = 'Блуза');

INSERT INTO fin_articlesubfamily (Oid, Ord, Code, Designation, Family, CreatedAt, UpdatedAt)
SELECT 'b1000004-0000-4000-8000-000000000004', 240, 240, 'Рубашка', f.Oid, datetime('now'), datetime('now')
FROM fin_articlefamily f WHERE f.Designation = 'Женское'
AND NOT EXISTS (SELECT 1 FROM fin_articlesubfamily sf WHERE sf.Family = f.Oid AND sf.Designation = 'Рубашка');

INSERT INTO fin_articlesubfamily (Oid, Ord, Code, Designation, Family, CreatedAt, UpdatedAt)
SELECT 'b1000005-0000-4000-8000-000000000005', 250, 250, 'Бомбер', f.Oid, datetime('now'), datetime('now')
FROM fin_articlefamily f WHERE f.Designation = 'Женское'
AND NOT EXISTS (SELECT 1 FROM fin_articlesubfamily sf WHERE sf.Family = f.Oid AND sf.Designation = 'Бомбер');

INSERT INTO fin_articlesubfamily (Oid, Ord, Code, Designation, Family, CreatedAt, UpdatedAt)
SELECT 'b1000006-0000-4000-8000-000000000006', 260, 260, 'Накидка', f.Oid, datetime('now'), datetime('now')
FROM fin_articlefamily f WHERE f.Designation = 'Женское'
AND NOT EXISTS (SELECT 1 FROM fin_articlesubfamily sf WHERE sf.Family = f.Oid AND sf.Designation = 'Накидка');

INSERT INTO fin_articlesubfamily (Oid, Ord, Code, Designation, Family, CreatedAt, UpdatedAt)
SELECT 'b1000007-0000-4000-8000-000000000007', 270, 270, 'Костюм с брюками', f.Oid, datetime('now'), datetime('now')
FROM fin_articlefamily f WHERE f.Designation = 'Женское'
AND NOT EXISTS (SELECT 1 FROM fin_articlesubfamily sf WHERE sf.Family = f.Oid AND sf.Designation = 'Костюм с брюками');

INSERT INTO fin_articlesubfamily (Oid, Ord, Code, Designation, Family, CreatedAt, UpdatedAt)
SELECT 'b1000008-0000-4000-8000-000000000008', 280, 280, 'Костюм с юбкой', f.Oid, datetime('now'), datetime('now')
FROM fin_articlefamily f WHERE f.Designation = 'Женское'
AND NOT EXISTS (SELECT 1 FROM fin_articlesubfamily sf WHERE sf.Family = f.Oid AND sf.Designation = 'Костюм с юбкой');

INSERT INTO fin_articlesubfamily (Oid, Ord, Code, Designation, Family, CreatedAt, UpdatedAt)
SELECT 'b1000009-0000-4000-8000-000000000009', 290, 290, 'Платье', f.Oid, datetime('now'), datetime('now')
FROM fin_articlefamily f WHERE f.Designation = 'Женское'
AND NOT EXISTS (SELECT 1 FROM fin_articlesubfamily sf WHERE sf.Family = f.Oid AND sf.Designation = 'Платье');

INSERT INTO fin_articlesubfamily (Oid, Ord, Code, Designation, Family, CreatedAt, UpdatedAt)
SELECT 'b1000010-0000-4000-8000-000000000010', 300, 300, 'Костюм спортивный', f.Oid, datetime('now'), datetime('now')
FROM fin_articlefamily f WHERE f.Designation = 'Женское'
AND NOT EXISTS (SELECT 1 FROM fin_articlesubfamily sf WHERE sf.Family = f.Oid AND sf.Designation = 'Костюм спортивный');

INSERT INTO fin_articlesubfamily (Oid, Ord, Code, Designation, Family, CreatedAt, UpdatedAt)
SELECT 'b1000011-0000-4000-8000-000000000011', 310, 310, 'Костюм с шортами', f.Oid, datetime('now'), datetime('now')
FROM fin_articlefamily f WHERE f.Designation = 'Женское'
AND NOT EXISTS (SELECT 1 FROM fin_articlesubfamily sf WHERE sf.Family = f.Oid AND sf.Designation = 'Костюм с шортами');

INSERT INTO fin_articlesubfamily (Oid, Ord, Code, Designation, Family, CreatedAt, UpdatedAt)
SELECT 'b1000012-0000-4000-8000-000000000012', 320, 320, 'Пиджак', f.Oid, datetime('now'), datetime('now')
FROM fin_articlefamily f WHERE f.Designation = 'Женское'
AND NOT EXISTS (SELECT 1 FROM fin_articlesubfamily sf WHERE sf.Family = f.Oid AND sf.Designation = 'Пиджак');

INSERT INTO fin_articlesubfamily (Oid, Ord, Code, Designation, Family, CreatedAt, UpdatedAt)
SELECT 'b1000013-0000-4000-8000-000000000013', 330, 330, 'Шорты', f.Oid, datetime('now'), datetime('now')
FROM fin_articlefamily f WHERE f.Designation = 'Женское'
AND NOT EXISTS (SELECT 1 FROM fin_articlesubfamily sf WHERE sf.Family = f.Oid AND sf.Designation = 'Шорты');

INSERT INTO fin_articlesubfamily (Oid, Ord, Code, Designation, Family, CreatedAt, UpdatedAt)
SELECT 'b1000014-0000-4000-8000-000000000014', 340, 340, 'Брюки', f.Oid, datetime('now'), datetime('now')
FROM fin_articlefamily f WHERE f.Designation = 'Женское'
AND NOT EXISTS (SELECT 1 FROM fin_articlesubfamily sf WHERE sf.Family = f.Oid AND sf.Designation = 'Брюки');

INSERT INTO fin_articlesubfamily (Oid, Ord, Code, Designation, Family, CreatedAt, UpdatedAt)
SELECT 'b1000015-0000-4000-8000-000000000015', 350, 350, 'Юбка', f.Oid, datetime('now'), datetime('now')
FROM fin_articlefamily f WHERE f.Designation = 'Женское'
AND NOT EXISTS (SELECT 1 FROM fin_articlesubfamily sf WHERE sf.Family = f.Oid AND sf.Designation = 'Юбка');

INSERT INTO fin_articlesubfamily (Oid, Ord, Code, Designation, Family, CreatedAt, UpdatedAt)
SELECT 'b1000016-0000-4000-8000-000000000016', 360, 360, 'Куртка', f.Oid, datetime('now'), datetime('now')
FROM fin_articlefamily f WHERE f.Designation = 'Женское'
AND NOT EXISTS (SELECT 1 FROM fin_articlesubfamily sf WHERE sf.Family = f.Oid AND sf.Designation = 'Куртка');

INSERT INTO fin_articlesubfamily (Oid, Ord, Code, Designation, Family, CreatedAt, UpdatedAt)
SELECT 'b1000017-0000-4000-8000-000000000017', 370, 370, 'Пальто', f.Oid, datetime('now'), datetime('now')
FROM fin_articlefamily f WHERE f.Designation = 'Женское'
AND NOT EXISTS (SELECT 1 FROM fin_articlesubfamily sf WHERE sf.Family = f.Oid AND sf.Designation = 'Пальто');

-- ─── Константы (демо KZ / ClothingStore) ──────────────────────────────────────
-- При другой БД подставьте Oid из fin_configurationvatrate (Value=12) и fin_articletype/class.

-- ─── Товары (пропуск, если Code уже есть) ─────────────────────────────────────

-- VAT 12% KZ, Type/Class/Unit — как в демо ClothingStore (при другой БД замените Oid).

INSERT INTO fin_article (Oid, Ord, Code, Designation, BarCode, ButtonImage, Family, SubFamily, Type, Class, UnitMeasure, UnitSize, VATOnTable, VATDirectSelling, Price1, Disabled, CreatedAt, UpdatedAt)
SELECT 'c2000001-0000-4000-8000-000000000001', 1001, 'TOP-001', 'Топ', '4870000000005', 'Assets/Images/Products/Shop/TOP-001-top-beige.jpg',
  (SELECT Oid FROM fin_articlefamily WHERE Designation='Женское' LIMIT 1),
  (SELECT sf.Oid FROM fin_articlesubfamily sf JOIN fin_articlefamily f ON sf.Family=f.Oid WHERE f.Designation='Женское' AND sf.Designation='Топ' LIMIT 1),
  'edf4841e-e451-4c7b-9bd0-ee02860ba937', '6924945d-f99e-476b-9c4d-78fb9e2b30a3', '4c81aa20-98ec-4497-b740-165cdb5fa395', '18f564aa-7da5-4a1c-9091-8014638b818c',
  'cee00590-7317-41b8-af46-66560401096b', 'cee00590-7317-41b8-af46-66560401096b', 8800, 0, datetime('now'), datetime('now')
WHERE NOT EXISTS (SELECT 1 FROM fin_article WHERE Code='TOP-001');

INSERT INTO fin_article (Oid, Ord, Code, Designation, BarCode, ButtonImage, Family, SubFamily, Type, Class, UnitMeasure, UnitSize, VATOnTable, VATDirectSelling, Price1, Disabled, CreatedAt, UpdatedAt)
SELECT 'c2000002-0000-4000-8000-000000000002', 1002, 'TS-001', 'Футболка', '4870000000012', 'Assets/Images/Products/Shop/TS-001-tshirt-blue-glitter.jpg',
  (SELECT Oid FROM fin_articlefamily WHERE Designation='Женское' LIMIT 1),
  (SELECT sf.Oid FROM fin_articlesubfamily sf JOIN fin_articlefamily f ON sf.Family=f.Oid WHERE f.Designation='Женское' AND sf.Designation='Футболка' LIMIT 1),
  'edf4841e-e451-4c7b-9bd0-ee02860ba937', '6924945d-f99e-476b-9c4d-78fb9e2b30a3', '4c81aa20-98ec-4497-b740-165cdb5fa395', '18f564aa-7da5-4a1c-9091-8014638b818c',
  'cee00590-7317-41b8-af46-66560401096b', 'cee00590-7317-41b8-af46-66560401096b', 12800, 0, datetime('now'), datetime('now')
WHERE NOT EXISTS (SELECT 1 FROM fin_article WHERE Code='TS-001');

INSERT INTO fin_article (Oid, Ord, Code, Designation, BarCode, ButtonImage, Family, SubFamily, Type, Class, UnitMeasure, UnitSize, VATOnTable, VATDirectSelling, Price1, Disabled, CreatedAt, UpdatedAt)
SELECT 'c2000003-0000-4000-8000-000000000003', 1003, 'BL-001', 'Блуза', '4870000000029', 'Assets/Images/Products/Shop/BL-001-blouse-white-pearl.jpg',
  (SELECT Oid FROM fin_articlefamily WHERE Designation='Женское' LIMIT 1),
  (SELECT sf.Oid FROM fin_articlesubfamily sf JOIN fin_articlefamily f ON sf.Family=f.Oid WHERE f.Designation='Женское' AND sf.Designation='Блуза' LIMIT 1),
  'edf4841e-e451-4c7b-9bd0-ee02860ba937', '6924945d-f99e-476b-9c4d-78fb9e2b30a3', '4c81aa20-98ec-4497-b740-165cdb5fa395', '18f564aa-7da5-4a1c-9091-8014638b818c',
  'cee00590-7317-41b8-af46-66560401096b', 'cee00590-7317-41b8-af46-66560401096b', 15000, 0, datetime('now'), datetime('now')
WHERE NOT EXISTS (SELECT 1 FROM fin_article WHERE Code='BL-001');

INSERT INTO fin_article (Oid, Ord, Code, Designation, BarCode, ButtonImage, Family, SubFamily, Type, Class, UnitMeasure, UnitSize, VATOnTable, VATDirectSelling, Price1, Disabled, CreatedAt, UpdatedAt)
SELECT 'c2000004-0000-4000-8000-000000000004', 1004, 'BL-002', 'Блуза', '4870000000036', 'Assets/Images/Products/Shop/BL-002-blouse-print-rhinestone.jpg',
  (SELECT Oid FROM fin_articlefamily WHERE Designation='Женское' LIMIT 1),
  (SELECT sf.Oid FROM fin_articlesubfamily sf JOIN fin_articlefamily f ON sf.Family=f.Oid WHERE f.Designation='Женское' AND sf.Designation='Блуза' LIMIT 1),
  'edf4841e-e451-4c7b-9bd0-ee02860ba937', '6924945d-f99e-476b-9c4d-78fb9e2b30a3', '4c81aa20-98ec-4497-b740-165cdb5fa395', '18f564aa-7da5-4a1c-9091-8014638b818c',
  'cee00590-7317-41b8-af46-66560401096b', 'cee00590-7317-41b8-af46-66560401096b', 15000, 0, datetime('now'), datetime('now')
WHERE NOT EXISTS (SELECT 1 FROM fin_article WHERE Code='BL-002');

INSERT INTO fin_article (Oid, Ord, Code, Designation, BarCode, ButtonImage, Family, SubFamily, Type, Class, UnitMeasure, UnitSize, VATOnTable, VATDirectSelling, Price1, Disabled, CreatedAt, UpdatedAt)
SELECT 'c2000005-0000-4000-8000-000000000005', 1005, 'BL-003', 'Блуза', '4870000000043', 'Assets/Images/Products/Shop/BL-003-blouse-peplum-white.jpg',
  (SELECT Oid FROM fin_articlefamily WHERE Designation='Женское' LIMIT 1),
  (SELECT sf.Oid FROM fin_articlesubfamily sf JOIN fin_articlefamily f ON sf.Family=f.Oid WHERE f.Designation='Женское' AND sf.Designation='Блуза' LIMIT 1),
  'edf4841e-e451-4c7b-9bd0-ee02860ba937', '6924945d-f99e-476b-9c4d-78fb9e2b30a3', '4c81aa20-98ec-4497-b740-165cdb5fa395', '18f564aa-7da5-4a1c-9091-8014638b818c',
  'cee00590-7317-41b8-af46-66560401096b', 'cee00590-7317-41b8-af46-66560401096b', 15000, 0, datetime('now'), datetime('now')
WHERE NOT EXISTS (SELECT 1 FROM fin_article WHERE Code='BL-003');

INSERT INTO fin_article (Oid, Ord, Code, Designation, BarCode, ButtonImage, Family, SubFamily, Type, Class, UnitMeasure, UnitSize, VATOnTable, VATDirectSelling, Price1, Disabled, CreatedAt, UpdatedAt)
SELECT 'c2000006-0000-4000-8000-000000000006', 1006, 'BL-004', 'Блуза', '4870000000050', 'Assets/Images/Products/Shop/BL-004-blouse-abstract-blue.jpg',
  (SELECT Oid FROM fin_articlefamily WHERE Designation='Женское' LIMIT 1),
  (SELECT sf.Oid FROM fin_articlesubfamily sf JOIN fin_articlefamily f ON sf.Family=f.Oid WHERE f.Designation='Женское' AND sf.Designation='Блуза' LIMIT 1),
  'edf4841e-e451-4c7b-9bd0-ee02860ba937', '6924945d-f99e-476b-9c4d-78fb9e2b30a3', '4c81aa20-98ec-4497-b740-165cdb5fa395', '18f564aa-7da5-4a1c-9091-8014638b818c',
  'cee00590-7317-41b8-af46-66560401096b', 'cee00590-7317-41b8-af46-66560401096b', 15000, 0, datetime('now'), datetime('now')
WHERE NOT EXISTS (SELECT 1 FROM fin_article WHERE Code='BL-004');

INSERT INTO fin_article (Oid, Ord, Code, Designation, BarCode, ButtonImage, Family, SubFamily, Type, Class, UnitMeasure, UnitSize, VATOnTable, VATDirectSelling, Price1, Disabled, CreatedAt, UpdatedAt)
SELECT 'c2000007-0000-4000-8000-000000000007', 1007, 'RS-001', 'Рубашка', '4870000000067', 'Assets/Images/Products/Shop/RS-001-shirt-stripe-blue.jpg',
  (SELECT Oid FROM fin_articlefamily WHERE Designation='Женское' LIMIT 1),
  (SELECT sf.Oid FROM fin_articlesubfamily sf JOIN fin_articlefamily f ON sf.Family=f.Oid WHERE f.Designation='Женское' AND sf.Designation='Рубашка' LIMIT 1),
  'edf4841e-e451-4c7b-9bd0-ee02860ba937', '6924945d-f99e-476b-9c4d-78fb9e2b30a3', '4c81aa20-98ec-4497-b740-165cdb5fa395', '18f564aa-7da5-4a1c-9091-8014638b818c',
  'cee00590-7317-41b8-af46-66560401096b', 'cee00590-7317-41b8-af46-66560401096b', 14000, 0, datetime('now'), datetime('now')
WHERE NOT EXISTS (SELECT 1 FROM fin_article WHERE Code='RS-001');

INSERT INTO fin_article (Oid, Ord, Code, Designation, BarCode, ButtonImage, Family, SubFamily, Type, Class, UnitMeasure, UnitSize, VATOnTable, VATDirectSelling, Price1, Disabled, CreatedAt, UpdatedAt)
SELECT 'c2000008-0000-4000-8000-000000000008', 1008, 'BK-001', 'Накидка', '4870000000074', 'Assets/Images/Products/Shop/BK-001-wrap-hood-white.jpg',
  (SELECT Oid FROM fin_articlefamily WHERE Designation='Женское' LIMIT 1),
  (SELECT sf.Oid FROM fin_articlesubfamily sf JOIN fin_articlefamily f ON sf.Family=f.Oid WHERE f.Designation='Женское' AND sf.Designation='Накидка' LIMIT 1),
  'edf4841e-e451-4c7b-9bd0-ee02860ba937', '6924945d-f99e-476b-9c4d-78fb9e2b30a3', '4c81aa20-98ec-4497-b740-165cdb5fa395', '18f564aa-7da5-4a1c-9091-8014638b818c',
  'cee00590-7317-41b8-af46-66560401096b', 'cee00590-7317-41b8-af46-66560401096b', 15000, 0, datetime('now'), datetime('now')
WHERE NOT EXISTS (SELECT 1 FROM fin_article WHERE Code='BK-001');

INSERT INTO fin_article (Oid, Ord, Code, Designation, BarCode, ButtonImage, Family, SubFamily, Type, Class, UnitMeasure, UnitSize, VATOnTable, VATDirectSelling, Price1, Disabled, CreatedAt, UpdatedAt)
SELECT 'c2000009-0000-4000-8000-000000000009', 1009, 'K2-001', 'Костюм с брюками', '4870000000081', 'Assets/Images/Products/Shop/K2-001-suit-print-bw.jpg',
  (SELECT Oid FROM fin_articlefamily WHERE Designation='Женское' LIMIT 1),
  (SELECT sf.Oid FROM fin_articlesubfamily sf JOIN fin_articlefamily f ON sf.Family=f.Oid WHERE f.Designation='Женское' AND sf.Designation='Костюм с брюками' LIMIT 1),
  'edf4841e-e451-4c7b-9bd0-ee02860ba937', '6924945d-f99e-476b-9c4d-78fb9e2b30a3', '4c81aa20-98ec-4497-b740-165cdb5fa395', '18f564aa-7da5-4a1c-9091-8014638b818c',
  'cee00590-7317-41b8-af46-66560401096b', 'cee00590-7317-41b8-af46-66560401096b', 40000, 0, datetime('now'), datetime('now')
WHERE NOT EXISTS (SELECT 1 FROM fin_article WHERE Code='K2-001');

INSERT INTO fin_article (Oid, Ord, Code, Designation, BarCode, ButtonImage, Family, SubFamily, Type, Class, UnitMeasure, UnitSize, VATOnTable, VATDirectSelling, Price1, Disabled, CreatedAt, UpdatedAt)
SELECT 'c2000010-0000-4000-8000-000000000010', 1010, 'K2-002', 'Костюм с брюками', '4870000000098', 'Assets/Images/Products/Shop/K2-002-suit-white-summer.jpg',
  (SELECT Oid FROM fin_articlefamily WHERE Designation='Женское' LIMIT 1),
  (SELECT sf.Oid FROM fin_articlesubfamily sf JOIN fin_articlefamily f ON sf.Family=f.Oid WHERE f.Designation='Женское' AND sf.Designation='Костюм с брюками' LIMIT 1),
  'edf4841e-e451-4c7b-9bd0-ee02860ba937', '6924945d-f99e-476b-9c4d-78fb9e2b30a3', '4c81aa20-98ec-4497-b740-165cdb5fa395', '18f564aa-7da5-4a1c-9091-8014638b818c',
  'cee00590-7317-41b8-af46-66560401096b', 'cee00590-7317-41b8-af46-66560401096b', 30000, 0, datetime('now'), datetime('now')
WHERE NOT EXISTS (SELECT 1 FROM fin_article WHERE Code='K2-002');

INSERT INTO fin_article (Oid, Ord, Code, Designation, BarCode, ButtonImage, Family, SubFamily, Type, Class, UnitMeasure, UnitSize, VATOnTable, VATDirectSelling, Price1, Disabled, CreatedAt, UpdatedAt)
SELECT 'c2000011-0000-4000-8000-000000000011', 1011, 'PJ-001', 'Пиджак', '4870000000104', 'Assets/Images/Products/Shop/PJ-001-blazer-dark.jpg',
  (SELECT Oid FROM fin_articlefamily WHERE Designation='Женское' LIMIT 1),
  (SELECT sf.Oid FROM fin_articlesubfamily sf JOIN fin_articlefamily f ON sf.Family=f.Oid WHERE f.Designation='Женское' AND sf.Designation='Пиджак' LIMIT 1),
  'edf4841e-e451-4c7b-9bd0-ee02860ba937', '6924945d-f99e-476b-9c4d-78fb9e2b30a3', '4c81aa20-98ec-4497-b740-165cdb5fa395', '18f564aa-7da5-4a1c-9091-8014638b818c',
  'cee00590-7317-41b8-af46-66560401096b', 'cee00590-7317-41b8-af46-66560401096b', 28000, 0, datetime('now'), datetime('now')
WHERE NOT EXISTS (SELECT 1 FROM fin_article WHERE Code='PJ-001');

INSERT INTO fin_article (Oid, Ord, Code, Designation, BarCode, ButtonImage, Family, SubFamily, Type, Class, UnitMeasure, UnitSize, VATOnTable, VATDirectSelling, Price1, Disabled, CreatedAt, UpdatedAt)
SELECT 'c2000012-0000-4000-8000-000000000012', 1012, 'BR-001', 'Брюки', '4870000000111', 'Assets/Images/Products/Shop/BR-001-pants-brown-vishnya.jpg',
  (SELECT Oid FROM fin_articlefamily WHERE Designation='Женское' LIMIT 1),
  (SELECT sf.Oid FROM fin_articlesubfamily sf JOIN fin_articlefamily f ON sf.Family=f.Oid WHERE f.Designation='Женское' AND sf.Designation='Брюки' LIMIT 1),
  'edf4841e-e451-4c7b-9bd0-ee02860ba937', '6924945d-f99e-476b-9c4d-78fb9e2b30a3', '4c81aa20-98ec-4497-b740-165cdb5fa395', '18f564aa-7da5-4a1c-9091-8014638b818c',
  'cee00590-7317-41b8-af46-66560401096b', 'cee00590-7317-41b8-af46-66560401096b', 13000, 0, datetime('now'), datetime('now')
WHERE NOT EXISTS (SELECT 1 FROM fin_article WHERE Code='BR-001');

INSERT INTO fin_article (Oid, Ord, Code, Designation, BarCode, ButtonImage, Family, SubFamily, Type, Class, UnitMeasure, UnitSize, VATOnTable, VATDirectSelling, Price1, Disabled, CreatedAt, UpdatedAt)
SELECT 'c2000013-0000-4000-8000-000000000013', 1013, 'BR-002', 'Брюки', '4870000000128', 'Assets/Images/Products/Shop/BR-002-pants-denim-marya.jpg',
  (SELECT Oid FROM fin_articlefamily WHERE Designation='Женское' LIMIT 1),
  (SELECT sf.Oid FROM fin_articlesubfamily sf JOIN fin_articlefamily f ON sf.Family=f.Oid WHERE f.Designation='Женское' AND sf.Designation='Брюки' LIMIT 1),
  'edf4841e-e451-4c7b-9bd0-ee02860ba937', '6924945d-f99e-476b-9c4d-78fb9e2b30a3', '4c81aa20-98ec-4497-b740-165cdb5fa395', '18f564aa-7da5-4a1c-9091-8014638b818c',
  'cee00590-7317-41b8-af46-66560401096b', 'cee00590-7317-41b8-af46-66560401096b', 17800, 0, datetime('now'), datetime('now')
WHERE NOT EXISTS (SELECT 1 FROM fin_article WHERE Code='BR-002');

INSERT INTO fin_article (Oid, Ord, Code, Designation, BarCode, ButtonImage, Family, SubFamily, Type, Class, UnitMeasure, UnitSize, VATOnTable, VATDirectSelling, Price1, Disabled, CreatedAt, UpdatedAt)
SELECT 'c2000014-0000-4000-8000-000000000014', 1014, 'BR-003', 'Брюки', '4870000000135', 'Assets/Images/Products/Shop/BR-003-pants-white-summer.jpg',
  (SELECT Oid FROM fin_articlefamily WHERE Designation='Женское' LIMIT 1),
  (SELECT sf.Oid FROM fin_articlesubfamily sf JOIN fin_articlefamily f ON sf.Family=f.Oid WHERE f.Designation='Женское' AND sf.Designation='Брюки' LIMIT 1),
  'edf4841e-e451-4c7b-9bd0-ee02860ba937', '6924945d-f99e-476b-9c4d-78fb9e2b30a3', '4c81aa20-98ec-4497-b740-165cdb5fa395', '18f564aa-7da5-4a1c-9091-8014638b818c',
  'cee00590-7317-41b8-af46-66560401096b', 'cee00590-7317-41b8-af46-66560401096b', 13000, 0, datetime('now'), datetime('now')
WHERE NOT EXISTS (SELECT 1 FROM fin_article WHERE Code='BR-003');

INSERT INTO fin_article (Oid, Ord, Code, Designation, BarCode, ButtonImage, Family, SubFamily, Type, Class, UnitMeasure, UnitSize, VATOnTable, VATDirectSelling, Price1, Disabled, CreatedAt, UpdatedAt)
SELECT 'c2000015-0000-4000-8000-000000000015', 1015, 'SH-001', 'Шорты', '4870000000142', 'Assets/Images/Products/Shop/SH-001-shorts-denim-love.jpg',
  (SELECT Oid FROM fin_articlefamily WHERE Designation='Женское' LIMIT 1),
  (SELECT sf.Oid FROM fin_articlesubfamily sf JOIN fin_articlefamily f ON sf.Family=f.Oid WHERE f.Designation='Женское' AND sf.Designation='Шорты' LIMIT 1),
  'edf4841e-e451-4c7b-9bd0-ee02860ba937', '6924945d-f99e-476b-9c4d-78fb9e2b30a3', '4c81aa20-98ec-4497-b740-165cdb5fa395', '18f564aa-7da5-4a1c-9091-8014638b818c',
  'cee00590-7317-41b8-af46-66560401096b', 'cee00590-7317-41b8-af46-66560401096b', 16800, 0, datetime('now'), datetime('now')
WHERE NOT EXISTS (SELECT 1 FROM fin_article WHERE Code='SH-001');

INSERT INTO fin_article (Oid, Ord, Code, Designation, BarCode, ButtonImage, Family, SubFamily, Type, Class, UnitMeasure, UnitSize, VATOnTable, VATDirectSelling, Price1, Disabled, CreatedAt, UpdatedAt)
SELECT 'c2000016-0000-4000-8000-000000000016', 1016, 'SK-001', 'Юбка', '4870000000159', 'Assets/Images/Products/Shop/SK-001-skirt-black-classic.jpg',
  (SELECT Oid FROM fin_articlefamily WHERE Designation='Женское' LIMIT 1),
  (SELECT sf.Oid FROM fin_articlesubfamily sf JOIN fin_articlefamily f ON sf.Family=f.Oid WHERE f.Designation='Женское' AND sf.Designation='Юбка' LIMIT 1),
  'edf4841e-e451-4c7b-9bd0-ee02860ba937', '6924945d-f99e-476b-9c4d-78fb9e2b30a3', '4c81aa20-98ec-4497-b740-165cdb5fa395', '18f564aa-7da5-4a1c-9091-8014638b818c',
  'cee00590-7317-41b8-af46-66560401096b', 'cee00590-7317-41b8-af46-66560401096b', 15000, 0, datetime('now'), datetime('now')
WHERE NOT EXISTS (SELECT 1 FROM fin_article WHERE Code='SK-001');

INSERT INTO fin_article (Oid, Ord, Code, Designation, BarCode, ButtonImage, Family, SubFamily, Type, Class, UnitMeasure, UnitSize, VATOnTable, VATDirectSelling, Price1, Disabled, CreatedAt, UpdatedAt)
SELECT 'c2000017-0000-4000-8000-000000000017', 1017, 'DR-001', 'Платье', '4870000000166', 'Assets/Images/Products/Shop/DR-001-dress-mustard-shirt.jpg',
  (SELECT Oid FROM fin_articlefamily WHERE Designation='Женское' LIMIT 1),
  (SELECT sf.Oid FROM fin_articlesubfamily sf JOIN fin_articlefamily f ON sf.Family=f.Oid WHERE f.Designation='Женское' AND sf.Designation='Платье' LIMIT 1),
  'edf4841e-e451-4c7b-9bd0-ee02860ba937', '6924945d-f99e-476b-9c4d-78fb9e2b30a3', '4c81aa20-98ec-4497-b740-165cdb5fa395', '18f564aa-7da5-4a1c-9091-8014638b818c',
  'cee00590-7317-41b8-af46-66560401096b', 'cee00590-7317-41b8-af46-66560401096b', 20000, 0, datetime('now'), datetime('now')
WHERE NOT EXISTS (SELECT 1 FROM fin_article WHERE Code='DR-001');

INSERT INTO fin_article (Oid, Ord, Code, Designation, BarCode, ButtonImage, Family, SubFamily, Type, Class, UnitMeasure, UnitSize, VATOnTable, VATDirectSelling, Price1, Disabled, CreatedAt, UpdatedAt)
SELECT 'c2000018-0000-4000-8000-000000000018', 1018, 'DR-002', 'Платье', '4870000000173', 'Assets/Images/Products/Shop/DR-002-dress-floral-white.jpg',
  (SELECT Oid FROM fin_articlefamily WHERE Designation='Женское' LIMIT 1),
  (SELECT sf.Oid FROM fin_articlesubfamily sf JOIN fin_articlefamily f ON sf.Family=f.Oid WHERE f.Designation='Женское' AND sf.Designation='Платье' LIMIT 1),
  'edf4841e-e451-4c7b-9bd0-ee02860ba937', '6924945d-f99e-476b-9c4d-78fb9e2b30a3', '4c81aa20-98ec-4497-b740-165cdb5fa395', '18f564aa-7da5-4a1c-9091-8014638b818c',
  'cee00590-7317-41b8-af46-66560401096b', 'cee00590-7317-41b8-af46-66560401096b', 25000, 0, datetime('now'), datetime('now')
WHERE NOT EXISTS (SELECT 1 FROM fin_article WHERE Code='DR-002');

-- ─── После импорта через Excel: BarCode + картинки ───────────────────────────

UPDATE fin_article SET BarCode='4870000000005', ButtonImage='Assets/Images/Products/Shop/TOP-001-top-beige.jpg' WHERE Code='TOP-001';
UPDATE fin_article SET BarCode='4870000000012', ButtonImage='Assets/Images/Products/Shop/TS-001-tshirt-blue-glitter.jpg' WHERE Code='TS-001';
UPDATE fin_article SET BarCode='4870000000029', ButtonImage='Assets/Images/Products/Shop/BL-001-blouse-white-pearl.jpg' WHERE Code='BL-001';
UPDATE fin_article SET BarCode='4870000000036', ButtonImage='Assets/Images/Products/Shop/BL-002-blouse-print-rhinestone.jpg' WHERE Code='BL-002';
UPDATE fin_article SET BarCode='4870000000043', ButtonImage='Assets/Images/Products/Shop/BL-003-blouse-peplum-white.jpg' WHERE Code='BL-003';
UPDATE fin_article SET BarCode='4870000000050', ButtonImage='Assets/Images/Products/Shop/BL-004-blouse-abstract-blue.jpg' WHERE Code='BL-004';
UPDATE fin_article SET BarCode='4870000000067', ButtonImage='Assets/Images/Products/Shop/RS-001-shirt-stripe-blue.jpg' WHERE Code='RS-001';
UPDATE fin_article SET BarCode='4870000000074', ButtonImage='Assets/Images/Products/Shop/BK-001-wrap-hood-white.jpg' WHERE Code='BK-001';
UPDATE fin_article SET BarCode='4870000000081', ButtonImage='Assets/Images/Products/Shop/K2-001-suit-print-bw.jpg' WHERE Code='K2-001';
UPDATE fin_article SET BarCode='4870000000098', ButtonImage='Assets/Images/Products/Shop/K2-002-suit-white-summer.jpg' WHERE Code='K2-002';
UPDATE fin_article SET BarCode='4870000000104', ButtonImage='Assets/Images/Products/Shop/PJ-001-blazer-dark.jpg' WHERE Code='PJ-001';
UPDATE fin_article SET BarCode='4870000000111', ButtonImage='Assets/Images/Products/Shop/BR-001-pants-brown-vishnya.jpg' WHERE Code='BR-001';
UPDATE fin_article SET BarCode='4870000000128', ButtonImage='Assets/Images/Products/Shop/BR-002-pants-denim-marya.jpg' WHERE Code='BR-002';
UPDATE fin_article SET BarCode='4870000000135', ButtonImage='Assets/Images/Products/Shop/BR-003-pants-white-summer.jpg' WHERE Code='BR-003';
UPDATE fin_article SET BarCode='4870000000142', ButtonImage='Assets/Images/Products/Shop/SH-001-shorts-denim-love.jpg' WHERE Code='SH-001';
UPDATE fin_article SET BarCode='4870000000159', ButtonImage='Assets/Images/Products/Shop/SK-001-skirt-black-classic.jpg' WHERE Code='SK-001';
UPDATE fin_article SET BarCode='4870000000166', ButtonImage='Assets/Images/Products/Shop/DR-001-dress-mustard-shirt.jpg' WHERE Code='DR-001';
UPDATE fin_article SET BarCode='4870000000173', ButtonImage='Assets/Images/Products/Shop/DR-002-dress-floral-white.jpg' WHERE Code='DR-002';
