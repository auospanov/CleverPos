-- Apply Russian names for I/O devices (existing database).

-- Считыватель ввода
UPDATE sys_configurationinputreader SET Designation = 'Универсальный сканер штрихкодов' WHERE Oid = 'f1c969b4-1022-4977-ac1a-26d3bec19c7a';
UPDATE sys_configurationinputreader SET Designation = 'Универсальный считыватель карт' WHERE Oid = '674da945-f177-4121-a538-72e8799404e6';

-- Дисплей покупателя
UPDATE sys_configurationpoledisplay SET Designation = 'Универсальный дисплей покупателя Appostar CPD-3230', StandByLine1 = 'CleverPos', StandByLine2 = 'Добро пожаловать' WHERE Oid = 'a8e7ecb0-1d8c-4cd5-af78-b369b22ac427';

-- Весы
UPDATE sys_configurationweighingmachine SET Designation = 'Универсальные весы' WHERE Oid = 'f4f91d26-a66f-44be-b12b-146bde20e638';
UPDATE sys_configurationweighingmachine SET Designation = 'Весы DIBAL G310' WHERE Oid = '4e1ba1d6-dca8-4c04-bb63-00408b9ec467';
