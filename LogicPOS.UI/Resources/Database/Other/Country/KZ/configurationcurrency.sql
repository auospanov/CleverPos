-- Currency Script for KZ;
UPDATE cfg_configurationcurrency SET ExchangeRate = 1.0000 WHERE Acronym = 'KZT';
UPDATE cfg_configurationcurrency SET ExchangeRate = 0.0019 WHERE Acronym = 'EUR';
UPDATE cfg_configurationcurrency SET ExchangeRate = 0.0021 WHERE Acronym = 'USD';
UPDATE cfg_configurationcurrency SET ExchangeRate = 0.0016 WHERE Acronym = 'GBP';
UPDATE cfg_configurationcurrency SET ExchangeRate = 0.0120 WHERE Acronym = 'BRL';
UPDATE cfg_configurationcurrency SET ExchangeRate = 0.2000 WHERE Acronym = 'MZN';
UPDATE cfg_configurationcurrency SET ExchangeRate = 0.0032 WHERE Acronym = 'AOA';
UPDATE cfg_configurationcurrency SET UpdatedBy = '090c5684-52ba-4d7a-8bc3-a00320ef503d', CreatedAt = '2014-02-28 14:02:28', UpdatedAt = '2019-03-11 23:16:18';
