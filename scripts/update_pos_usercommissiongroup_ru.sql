-- Apply Russian names for user commission groups (existing database, Retail theme).
UPDATE pos_usercommissiongroup SET Designation = 'Прилавок' WHERE Oid = '8dd94fe3-e124-4a86-b112-81d184672a58';
UPDATE pos_usercommissiongroup SET Designation = 'Продавец' WHERE Oid = '4a18e3a7-5152-4c21-a3bc-93efbb24c34e';
UPDATE pos_usercommissiongroup SET Designation = 'Кассир' WHERE Oid = '1490a7b8-5092-4084-ab96-6c8efca8f5b8';
UPDATE pos_usercommissiongroup SET Designation = 'Супервайзер' WHERE Oid = '1bf83136-3a64-41b8-942e-19d409a5d67d';
UPDATE pos_usercommissiongroup SET Designation = 'Менеджер' WHERE Oid = '2231a819-aeef-43e9-90a9-546d30ca90a3';
UPDATE pos_usercommissiongroup SET Designation = 'Кладовщик' WHERE Oid = 'cca989d4-d62f-4c08-95e7-117b41c4d090';
