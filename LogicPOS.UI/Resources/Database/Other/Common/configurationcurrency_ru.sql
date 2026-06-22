-- Update currency names to Russian (run once on existing logicposdb.db)
-- Safe to re-run: inserts missing CIS currencies, then sets Designation/Entity by Acronym

INSERT INTO cfg_configurationcurrency (Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity)
SELECT '3f8e1a2b-4c5d-6e7f-8a9b-0c1d2e3f4a5b', 5, 5, 'KZT', 520.0000, 'Казахстанский тенге', '₸', 'Казахстан' WHERE NOT EXISTS (SELECT 1 FROM cfg_configurationcurrency WHERE Acronym = 'KZT');

INSERT INTO cfg_configurationcurrency (Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity)
SELECT 'a1b2c3d4-e5f6-4789-a012-3456789abcde', 640, 640, 'RUB', 100.0000, 'Российский рубль', '₽', 'Россия' WHERE NOT EXISTS (SELECT 1 FROM cfg_configurationcurrency WHERE Acronym = 'RUB');

INSERT INTO cfg_configurationcurrency (Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity)
SELECT 'b2c3d4e5-f6a7-4890-b123-456789abcdef', 650, 650, 'UAH', 40.0000, 'Украинская гривна', '₴', 'Украина' WHERE NOT EXISTS (SELECT 1 FROM cfg_configurationcurrency WHERE Acronym = 'UAH');

INSERT INTO cfg_configurationcurrency (Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity)
SELECT 'c3d4e5f6-a7b8-4901-c234-56789abcdef0', 660, 660, 'BYN', 3.2000, 'Белорусский рубль', 'Br', 'Беларусь' WHERE NOT EXISTS (SELECT 1 FROM cfg_configurationcurrency WHERE Acronym = 'BYN');

INSERT INTO cfg_configurationcurrency (Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity)
SELECT 'd4e5f6a7-b8c9-4012-d345-6789abcdef01', 670, 670, 'KGS', 90.0000, 'Киргизский сом', 'с', 'Киргизия' WHERE NOT EXISTS (SELECT 1 FROM cfg_configurationcurrency WHERE Acronym = 'KGS');

INSERT INTO cfg_configurationcurrency (Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity)
SELECT 'e5f6a7b8-c9d0-4123-e456-789abcdef012', 680, 680, 'TJS', 11.0000, 'Таджикский сомони', 'SM', 'Таджикистан' WHERE NOT EXISTS (SELECT 1 FROM cfg_configurationcurrency WHERE Acronym = 'TJS');

INSERT INTO cfg_configurationcurrency (Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity)
SELECT 'f6a7b8c9-d0e1-4234-f567-89abcdef0123', 690, 690, 'UZS', 12500.0000, 'Узбекский сум', 'сўм', 'Узбекистан' WHERE NOT EXISTS (SELECT 1 FROM cfg_configurationcurrency WHERE Acronym = 'UZS');

INSERT INTO cfg_configurationcurrency (Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity)
SELECT 'a7b8c9d0-e1f2-4345-a678-9abcdef01234', 700, 700, 'AMD', 400.0000, 'Армянский драм', '֏', 'Армения' WHERE NOT EXISTS (SELECT 1 FROM cfg_configurationcurrency WHERE Acronym = 'AMD');

INSERT INTO cfg_configurationcurrency (Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity)
SELECT 'b8c9d0e1-f2a3-4456-b789-abcdef012345', 710, 710, 'AZN', 1.7000, 'Азербайджанский манат', '₼', 'Азербайджан' WHERE NOT EXISTS (SELECT 1 FROM cfg_configurationcurrency WHERE Acronym = 'AZN');

INSERT INTO cfg_configurationcurrency (Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity)
SELECT 'c9d0e1f2-a3b4-4567-c89a-bcdef0123456', 720, 720, 'GEL', 2.7000, 'Грузинский лари', '₾', 'Грузия' WHERE NOT EXISTS (SELECT 1 FROM cfg_configurationcurrency WHERE Acronym = 'GEL');

INSERT INTO cfg_configurationcurrency (Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity)
SELECT 'd0e1f2a3-b4c5-4678-d9ab-cdef01234567', 730, 730, 'MDL', 18.0000, 'Молдавский лей', 'L', 'Молдова' WHERE NOT EXISTS (SELECT 1 FROM cfg_configurationcurrency WHERE Acronym = 'MDL');

INSERT INTO cfg_configurationcurrency (Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity)
SELECT 'e1f2a3b4-c5d6-4789-eabc-def012345678', 740, 740, 'TMT', 3.5000, 'Туркменский манат', 'm', 'Туркменистан' WHERE NOT EXISTS (SELECT 1 FROM cfg_configurationcurrency WHERE Acronym = 'TMT');

UPDATE cfg_configurationcurrency SET Designation = 'Армянский драм', Entity = 'Армения' WHERE Acronym = 'AMD';
UPDATE cfg_configurationcurrency SET Designation = 'Кванза', Entity = 'Ангола' WHERE Acronym = 'AOA';
UPDATE cfg_configurationcurrency SET Designation = 'Аргентинское песо', Entity = 'Аргентина' WHERE Acronym = 'ARS';
UPDATE cfg_configurationcurrency SET Designation = 'Австралийский доллар', Entity = 'Австралия и др.' WHERE Acronym = 'AUD';
UPDATE cfg_configurationcurrency SET Designation = 'Арубский гульден', Entity = 'Аруба' WHERE Acronym = 'AWG';
UPDATE cfg_configurationcurrency SET Designation = 'Азербайджанский манат', Entity = 'Азербайджан' WHERE Acronym = 'AZN';
UPDATE cfg_configurationcurrency SET Designation = 'Конвертируемая марка', Entity = 'Босния и Герцеговина' WHERE Acronym = 'BAM';
UPDATE cfg_configurationcurrency SET Designation = 'Барбадосский доллар', Entity = 'Барбадос' WHERE Acronym = 'BBD';
UPDATE cfg_configurationcurrency SET Designation = 'Бермудский доллар', Entity = 'Бермуды' WHERE Acronym = 'BMD';
UPDATE cfg_configurationcurrency SET Designation = 'Брунейский доллар', Entity = 'Бруней' WHERE Acronym = 'BND';
UPDATE cfg_configurationcurrency SET Designation = 'Бразильский реал', Entity = 'Бразилия' WHERE Acronym = 'BRL';
UPDATE cfg_configurationcurrency SET Designation = 'Багамский доллар', Entity = 'Багамы' WHERE Acronym = 'BSD';
UPDATE cfg_configurationcurrency SET Designation = 'Пула', Entity = 'Ботсвана' WHERE Acronym = 'BWP';
UPDATE cfg_configurationcurrency SET Designation = 'Белорусский рубль', Entity = 'Беларусь' WHERE Acronym = 'BYN';
UPDATE cfg_configurationcurrency SET Designation = 'Белорусский рубль (старый)', Entity = 'Беларусь' WHERE Acronym = 'BYR';
UPDATE cfg_configurationcurrency SET Designation = 'Белизский доллар', Entity = 'Белиз' WHERE Acronym = 'BZD';
UPDATE cfg_configurationcurrency SET Designation = 'Канадский доллар', Entity = 'Канада' WHERE Acronym = 'CAD';
UPDATE cfg_configurationcurrency SET Designation = 'Швейцарский франк', Entity = 'Швейцария, Лихтенштейн' WHERE Acronym = 'CHF';
UPDATE cfg_configurationcurrency SET Designation = 'Китайский юань', Entity = 'Китай' WHERE Acronym = 'CNY';
UPDATE cfg_configurationcurrency SET Designation = 'Коста-риканский колон', Entity = 'Коста-Рика' WHERE Acronym = 'CRC';
UPDATE cfg_configurationcurrency SET Designation = 'Чешская крона', Entity = 'Чехия' WHERE Acronym = 'CZK';
UPDATE cfg_configurationcurrency SET Designation = 'Датская крона', Entity = 'Дания, Фареры, Гренландия' WHERE Acronym = 'DKK';
UPDATE cfg_configurationcurrency SET Designation = 'Доминиканское песо', Entity = 'Доминиканская Республика' WHERE Acronym = 'DOP';
UPDATE cfg_configurationcurrency SET Designation = 'Египетский фунт', Entity = 'Египет' WHERE Acronym = 'EGP';
UPDATE cfg_configurationcurrency SET Designation = 'Евро', Entity = 'Европейский союз и др.' WHERE Acronym = 'EUR';
UPDATE cfg_configurationcurrency SET Designation = 'Доллар Фиджи', Entity = 'Фиджи' WHERE Acronym = 'FJD';
UPDATE cfg_configurationcurrency SET Designation = 'Фунт Фолклендских островов', Entity = 'Фолклендские острова' WHERE Acronym = 'FKP';
UPDATE cfg_configurationcurrency SET Designation = 'Фунт стерлингов', Entity = 'Великобритания и заморские территории' WHERE Acronym = 'GBP';
UPDATE cfg_configurationcurrency SET Designation = 'Грузинский лари', Entity = 'Грузия' WHERE Acronym = 'GEL';
UPDATE cfg_configurationcurrency SET Designation = 'Гибралтарский фунт', Entity = 'Гибралтар' WHERE Acronym = 'GIP';
UPDATE cfg_configurationcurrency SET Designation = 'Кетсаль', Entity = 'Гватемала' WHERE Acronym = 'GTQ';
UPDATE cfg_configurationcurrency SET Designation = 'Гайанский доллар', Entity = 'Гайана' WHERE Acronym = 'GYD';
UPDATE cfg_configurationcurrency SET Designation = 'Гонконгский доллар', Entity = 'Гонконг' WHERE Acronym = 'HKD';
UPDATE cfg_configurationcurrency SET Designation = 'Лемпира', Entity = 'Гондурас' WHERE Acronym = 'HNL';
UPDATE cfg_configurationcurrency SET Designation = 'Хорватская куна', Entity = 'Хорватия' WHERE Acronym = 'HRK';
UPDATE cfg_configurationcurrency SET Designation = 'Венгерский форинт', Entity = 'Венгрия' WHERE Acronym = 'HUF';
UPDATE cfg_configurationcurrency SET Designation = 'Индонезийская рупия', Entity = 'Индонезия' WHERE Acronym = 'IDR';
UPDATE cfg_configurationcurrency SET Designation = 'Ямайский доллар', Entity = 'Ямайка' WHERE Acronym = 'JMD';
UPDATE cfg_configurationcurrency SET Designation = 'Японская иена', Entity = 'Япония' WHERE Acronym = 'JPY';
UPDATE cfg_configurationcurrency SET Designation = 'Киргизский сом', Entity = 'Киргизия' WHERE Acronym = 'KGS';
UPDATE cfg_configurationcurrency SET Designation = 'Доллар Каймановых островов', Entity = 'Каймановы острова' WHERE Acronym = 'KYD';
UPDATE cfg_configurationcurrency SET Designation = 'Казахстанский тенге', Entity = 'Казахстан' WHERE Acronym = 'KZT';
UPDATE cfg_configurationcurrency SET Designation = 'Ливанский фунт', Entity = 'Ливан' WHERE Acronym = 'LBP';
UPDATE cfg_configurationcurrency SET Designation = 'Либерийский доллар', Entity = 'Либерия' WHERE Acronym = 'LRD';
UPDATE cfg_configurationcurrency SET Designation = 'Литовский лит', Entity = 'Литва' WHERE Acronym = 'LTL';
UPDATE cfg_configurationcurrency SET Designation = 'Латвийский лат', Entity = 'Латвия' WHERE Acronym = 'LVL';
UPDATE cfg_configurationcurrency SET Designation = 'Молдавский лей', Entity = 'Молдова' WHERE Acronym = 'MDL';
UPDATE cfg_configurationcurrency SET Designation = 'Малайзийский ринггит', Entity = 'Малайзия' WHERE Acronym = 'MYR';
UPDATE cfg_configurationcurrency SET Designation = 'Мозамбикский метикал', Entity = 'Мозамбик' WHERE Acronym = 'MZN';
UPDATE cfg_configurationcurrency SET Designation = 'Никарагуанская кордоба', Entity = 'Никарагуа' WHERE Acronym = 'NIO';
UPDATE cfg_configurationcurrency SET Designation = 'Норвежская крона', Entity = 'Норвегия и др.' WHERE Acronym = 'NOK';
UPDATE cfg_configurationcurrency SET Designation = 'Новозеландский доллар', Entity = 'Новая Зеландия и др.' WHERE Acronym = 'NZD';
UPDATE cfg_configurationcurrency SET Designation = 'Перуанский соль', Entity = 'Перу' WHERE Acronym = 'PEN';
UPDATE cfg_configurationcurrency SET Designation = 'Филиппинское песо', Entity = 'Филиппины' WHERE Acronym = 'PHP';
UPDATE cfg_configurationcurrency SET Designation = 'Парагвайский гуарани', Entity = 'Парагвай' WHERE Acronym = 'PYG';
UPDATE cfg_configurationcurrency SET Designation = 'Румынский лей', Entity = 'Румыния' WHERE Acronym = 'RON';
UPDATE cfg_configurationcurrency SET Designation = 'Российский рубль', Entity = 'Россия' WHERE Acronym = 'RUB';
UPDATE cfg_configurationcurrency SET Designation = 'Доллар Соломоновых Островов', Entity = 'Соломоновы острова' WHERE Acronym = 'SBD';
UPDATE cfg_configurationcurrency SET Designation = 'Шведская крона', Entity = 'Швеция' WHERE Acronym = 'SEK';
UPDATE cfg_configurationcurrency SET Designation = 'Сингапурский доллар', Entity = 'Сингапур' WHERE Acronym = 'SGD';
UPDATE cfg_configurationcurrency SET Designation = 'Фунт Святой Елены', Entity = 'Остров Святой Елены' WHERE Acronym = 'SHP';
UPDATE cfg_configurationcurrency SET Designation = 'Сомалийский шиллинг', Entity = 'Сомали' WHERE Acronym = 'SOS';
UPDATE cfg_configurationcurrency SET Designation = 'Суринамский доллар', Entity = 'Суринам' WHERE Acronym = 'SRD';
UPDATE cfg_configurationcurrency SET Designation = 'Сирийский фунт', Entity = 'Сирия' WHERE Acronym = 'SYP';
UPDATE cfg_configurationcurrency SET Designation = 'Таджикский сомони', Entity = 'Таджикистан' WHERE Acronym = 'TJS';
UPDATE cfg_configurationcurrency SET Designation = 'Туркменский манат', Entity = 'Туркменистан' WHERE Acronym = 'TMT';
UPDATE cfg_configurationcurrency SET Designation = 'Турецкая лира', Entity = 'Турция' WHERE Acronym = 'TRY';
UPDATE cfg_configurationcurrency SET Designation = 'Доллар Тринидада и Тобаго', Entity = 'Тринидад и Тобаго' WHERE Acronym = 'TTD';
UPDATE cfg_configurationcurrency SET Designation = 'Новый тайваньский доллар', Entity = 'Тайвань' WHERE Acronym = 'TWD';
UPDATE cfg_configurationcurrency SET Designation = 'Украинская гривна', Entity = 'Украина' WHERE Acronym = 'UAH';
UPDATE cfg_configurationcurrency SET Designation = 'Доллар США', Entity = 'США и др.' WHERE Acronym = 'USD';
UPDATE cfg_configurationcurrency SET Designation = 'Узбекский сум', Entity = 'Узбекистан' WHERE Acronym = 'UZS';
UPDATE cfg_configurationcurrency SET Designation = 'Восточнокарибский доллар', Entity = 'Восточные Карибы' WHERE Acronym = 'XCD';
UPDATE cfg_configurationcurrency SET Designation = 'Южноафриканский рэнд', Entity = 'ЮАР, Лесото, Намибия' WHERE Acronym = 'ZAR';

UPDATE cfg_configurationcurrency SET Ord = 5, Code = 5 WHERE Acronym = 'KZT';

UPDATE cfg_configurationcurrency SET Disabled = NULL, DeletedAt = NULL WHERE Acronym IN ('KZT','RUB','UAH','BYN','KGS','TJS','UZS','AMD','AZN','GEL','MDL','TMT');

UPDATE cfg_configurationcurrency SET Designation = '-- Выберите --' WHERE Oid = '00000000-0000-0000-0000-000000000001';
