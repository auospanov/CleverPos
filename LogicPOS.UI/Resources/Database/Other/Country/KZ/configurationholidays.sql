-- Праздники Казахстана;

DELETE FROM cfg_configurationholidays;

INSERT INTO cfg_configurationholidays (Oid, Ord, Code, Year, Month, Day, Designation, Description, Fixed) VALUES ('a1000001-0000-4000-8000-000000000001',  10,  10, 0,  1,  1, 'Новый год', 'Новый год', 1);
INSERT INTO cfg_configurationholidays (Oid, Ord, Code, Year, Month, Day, Designation, Description, Fixed) VALUES ('a1000001-0000-4000-8000-000000000002',  20,  20, 0,  1,  2, 'Новогодние каникулы', 'Новогодние каникулы', 1);
INSERT INTO cfg_configurationholidays (Oid, Ord, Code, Year, Month, Day, Designation, Description, Fixed) VALUES ('a1000001-0000-4000-8000-000000000003',  30,  30, 0,  3,  8, 'Международный женский день', 'Международный женский день', 1);
INSERT INTO cfg_configurationholidays (Oid, Ord, Code, Year, Month, Day, Designation, Description, Fixed) VALUES ('a1000001-0000-4000-8000-000000000004',  40,  40, 0,  3, 21, 'Наурыз', 'Наурыз', 1);
INSERT INTO cfg_configurationholidays (Oid, Ord, Code, Year, Month, Day, Designation, Description, Fixed) VALUES ('a1000001-0000-4000-8000-000000000005',  50,  50, 0,  3, 22, 'Наурыз (каникулы)', 'Наурыз (каникулы)', 1);
INSERT INTO cfg_configurationholidays (Oid, Ord, Code, Year, Month, Day, Designation, Description, Fixed) VALUES ('a1000001-0000-4000-8000-000000000006',  60,  60, 0,  3, 23, 'Наурыз (каникулы)', 'Наурыз (каникулы)', 1);
INSERT INTO cfg_configurationholidays (Oid, Ord, Code, Year, Month, Day, Designation, Description, Fixed) VALUES ('a1000001-0000-4000-8000-000000000007',  70,  70, 0,  5,  1, 'Праздник единства народа Казахстана', 'Праздник единства народа Казахстана', 1);
INSERT INTO cfg_configurationholidays (Oid, Ord, Code, Year, Month, Day, Designation, Description, Fixed) VALUES ('a1000001-0000-4000-8000-000000000008',  80,  80, 0,  5,  7, 'День защитника Отечества', 'День защитника Отечества', 1);
INSERT INTO cfg_configurationholidays (Oid, Ord, Code, Year, Month, Day, Designation, Description, Fixed) VALUES ('a1000001-0000-4000-8000-000000000009',  90,  90, 0,  5,  9, 'День Победы', 'День Победы', 1);
INSERT INTO cfg_configurationholidays (Oid, Ord, Code, Year, Month, Day, Designation, Description, Fixed) VALUES ('a1000001-0000-4000-8000-00000000000a', 100, 100, 0,  7,  6, 'День столицы', 'День столицы', 1);
INSERT INTO cfg_configurationholidays (Oid, Ord, Code, Year, Month, Day, Designation, Description, Fixed) VALUES ('a1000001-0000-4000-8000-00000000000b', 110, 110, 0,  8, 30, 'День Конституции', 'День Конституции', 1);
INSERT INTO cfg_configurationholidays (Oid, Ord, Code, Year, Month, Day, Designation, Description, Fixed) VALUES ('a1000001-0000-4000-8000-00000000000c', 120, 120, 0, 10, 25, 'День Республики', 'День Республики', 1);
INSERT INTO cfg_configurationholidays (Oid, Ord, Code, Year, Month, Day, Designation, Description, Fixed) VALUES ('a1000001-0000-4000-8000-00000000000d', 130, 130, 0, 12, 16, 'День Независимости', 'День Независимости', 1);

UPDATE cfg_configurationholidays SET UpdatedBy = '090c5684-52ba-4d7a-8bc3-a00320ef503d', CreatedAt = '2014-02-28 14:02:28', UpdatedAt = '2019-03-11 23:16:18';
