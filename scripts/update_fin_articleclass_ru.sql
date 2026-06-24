-- Apply Russian names for article classes (existing database).
UPDATE fin_articleclass SET Designation = 'Товары' WHERE Oid = '6924945d-f99e-476b-9c4d-78fb9e2b30a3';
UPDATE fin_articleclass SET Designation = 'Услуги' WHERE Oid = '7622e5d2-2d52-4be9-bb8b-e5efae5ec791';
UPDATE fin_articleclass SET Designation = 'Прочее (авансы и т.д.)' WHERE Oid = '0763a749-0066-49f1-a9cf-5f9577395476';
UPDATE fin_articleclass SET Designation = 'Налог (кроме НДС)' WHERE Oid = '82c158f9-9c30-468f-9d15-8bde112998f4';
UPDATE fin_articleclass SET Designation = 'Прочие налоги' WHERE Oid = 'c14a792e-c7f7-403e-8e2c-d2c36aca0e03';
