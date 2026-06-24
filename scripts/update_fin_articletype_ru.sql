-- Apply Russian names for system article types (existing database).
UPDATE fin_articletype SET Designation = 'Обычный' WHERE Oid = 'edf4841e-e451-4c7b-9bd0-ee02860ba937';
UPDATE fin_articletype SET Designation = 'Дополнение' WHERE Oid = '0f4300ea-6386-4896-b19d-71f1fa5907ab';
UPDATE fin_articletype SET Designation = 'Потребление' WHERE Oid = '3b7489d0-c5d4-4ad4-a91a-7a7af0bd4f1d';
UPDATE fin_articletype SET Designation = 'Чаевые' WHERE Oid = '3ea8eadf-6f60-46bd-a70c-cea11a7bfc94';
UPDATE fin_articletype SET Designation = 'Карта клиента' WHERE Oid = '49ea35ba-35f3-440f-946e-ab32578ed741';
UPDATE fin_articletype SET Designation = 'Информационный' WHERE Oid = '3f2fafe9-5758-4afd-9e9a-c442520e0894';
