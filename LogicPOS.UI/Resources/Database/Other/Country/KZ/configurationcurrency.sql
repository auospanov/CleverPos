-- Currency Script for KZ: ensure CIS currencies exist, then set KZT-centric exchange rates.

INSERT INTO cfg_configurationcurrency (Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity)
SELECT '3f8e1a2b-4c5d-6e7f-8a9b-0c1d2e3f4a5b', 5, 5, 'KZT', 520.0000, 'Казахстанский тенге', '₸', 'Казахстан'
WHERE NOT EXISTS (SELECT 1 FROM cfg_configurationcurrency WHERE Acronym = 'KZT');

INSERT INTO cfg_configurationcurrency (Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity)
SELECT 'a1b2c3d4-e5f6-4789-a012-3456789abcde', 640, 640, 'RUB', 100.0000, 'Российский рубль', '₽', 'Россия'
WHERE NOT EXISTS (SELECT 1 FROM cfg_configurationcurrency WHERE Acronym = 'RUB');

INSERT INTO cfg_configurationcurrency (Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity)
SELECT 'b2c3d4e5-f6a7-4890-b123-456789abcdef', 650, 650, 'UAH', 40.0000, 'Украинская гривна', '₴', 'Украина'
WHERE NOT EXISTS (SELECT 1 FROM cfg_configurationcurrency WHERE Acronym = 'UAH');

INSERT INTO cfg_configurationcurrency (Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity)
SELECT 'c3d4e5f6-a7b8-4901-c234-56789abcdef0', 660, 660, 'BYN', 3.2000, 'Белорусский рубль', 'Br', 'Беларусь'
WHERE NOT EXISTS (SELECT 1 FROM cfg_configurationcurrency WHERE Acronym = 'BYN');

INSERT INTO cfg_configurationcurrency (Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity)
SELECT 'd4e5f6a7-b8c9-4012-d345-6789abcdef01', 670, 670, 'KGS', 90.0000, 'Киргизский сом', 'с', 'Киргизия'
WHERE NOT EXISTS (SELECT 1 FROM cfg_configurationcurrency WHERE Acronym = 'KGS');

INSERT INTO cfg_configurationcurrency (Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity)
SELECT 'e5f6a7b8-c9d0-4123-e456-789abcdef012', 680, 680, 'TJS', 11.0000, 'Таджикский сомони', 'SM', 'Таджикистан'
WHERE NOT EXISTS (SELECT 1 FROM cfg_configurationcurrency WHERE Acronym = 'TJS');

INSERT INTO cfg_configurationcurrency (Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity)
SELECT 'f6a7b8c9-d0e1-4234-f567-89abcdef0123', 690, 690, 'UZS', 12500.0000, 'Узбекский сум', 'сўм', 'Узбекистан'
WHERE NOT EXISTS (SELECT 1 FROM cfg_configurationcurrency WHERE Acronym = 'UZS');

INSERT INTO cfg_configurationcurrency (Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity)
SELECT 'a7b8c9d0-e1f2-4345-a678-9abcdef01234', 700, 700, 'AMD', 400.0000, 'Армянский драм', '֏', 'Армения'
WHERE NOT EXISTS (SELECT 1 FROM cfg_configurationcurrency WHERE Acronym = 'AMD');

INSERT INTO cfg_configurationcurrency (Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity)
SELECT 'b8c9d0e1-f2a3-4456-b789-abcdef012345', 710, 710, 'AZN', 1.7000, 'Азербайджанский манат', '₼', 'Азербайджан'
WHERE NOT EXISTS (SELECT 1 FROM cfg_configurationcurrency WHERE Acronym = 'AZN');

INSERT INTO cfg_configurationcurrency (Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity)
SELECT 'c9d0e1f2-a3b4-4567-c89a-bcdef0123456', 720, 720, 'GEL', 2.7000, 'Грузинский лари', '₾', 'Грузия'
WHERE NOT EXISTS (SELECT 1 FROM cfg_configurationcurrency WHERE Acronym = 'GEL');

INSERT INTO cfg_configurationcurrency (Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity)
SELECT 'd0e1f2a3-b4c5-4678-d9ab-cdef01234567', 730, 730, 'MDL', 18.0000, 'Молдавский лей', 'L', 'Молдова'
WHERE NOT EXISTS (SELECT 1 FROM cfg_configurationcurrency WHERE Acronym = 'MDL');

INSERT INTO cfg_configurationcurrency (Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity)
SELECT 'e1f2a3b4-c5d6-4789-eabc-def012345678', 740, 740, 'TMT', 3.5000, 'Туркменский манат', 'm', 'Туркменистан'
WHERE NOT EXISTS (SELECT 1 FROM cfg_configurationcurrency WHERE Acronym = 'TMT');

UPDATE cfg_configurationcurrency SET Disabled = NULL, DeletedAt = NULL WHERE Acronym IN ('KZT','RUB','UAH','BYN','KGS','TJS','UZS','AMD','AZN','GEL','MDL','TMT');
UPDATE cfg_configurationcurrency SET Ord = 5, Code = 5 WHERE Acronym = 'KZT';
UPDATE cfg_configurationcurrency SET ExchangeRate = 1.0000 WHERE Acronym = 'KZT';
UPDATE cfg_configurationcurrency SET ExchangeRate = 0.0019 WHERE Acronym = 'EUR';
UPDATE cfg_configurationcurrency SET ExchangeRate = 0.0021 WHERE Acronym = 'USD';
UPDATE cfg_configurationcurrency SET ExchangeRate = 0.0016 WHERE Acronym = 'GBP';
UPDATE cfg_configurationcurrency SET ExchangeRate = 0.0120 WHERE Acronym = 'BRL';
UPDATE cfg_configurationcurrency SET ExchangeRate = 0.2000 WHERE Acronym = 'MZN';
UPDATE cfg_configurationcurrency SET ExchangeRate = 0.0032 WHERE Acronym = 'AOA';
UPDATE cfg_configurationcurrency SET UpdatedBy = '090c5684-52ba-4d7a-8bc3-a00320ef503d', CreatedAt = '2014-02-28 14:02:28', UpdatedAt = '2019-03-11 23:16:18';
