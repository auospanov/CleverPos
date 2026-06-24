-- Apply Russian names for customer types and discount groups (existing database).

-- Тип клиента
UPDATE erp_customertype SET Designation = 'Обычный' WHERE Oid = 'a4b3811f-9851-430d-810e-f8be7ac3f392';
UPDATE erp_customertype SET Designation = 'Редкий' WHERE Oid = 'f2a3a388-1c91-4cb6-b96c-a0a40872c53f';
UPDATE erp_customertype SET Designation = 'Хороший' WHERE Oid = 'e244d1bc-8ace-40f0-b275-7124188d9991';
UPDATE erp_customertype SET Designation = 'Очень хороший' WHERE Oid = '2ea60fc9-b8d6-4e29-b322-856c898400fd';
UPDATE erp_customertype SET Designation = 'Корпоративный' WHERE Oid = 'ca2e73ba-5cac-4d45-860e-ccb64b061778';
UPDATE erp_customertype SET Designation = 'Выходные' WHERE Oid = '15120324-9e28-4e74-8ea0-241aa9be7914';

-- Группы скидок
UPDATE erp_customerdiscountgroup SET Designation = 'Минимальная' WHERE Oid = '72dfb8e2-3a48-4d01-8800-8d497e599fbe';
UPDATE erp_customerdiscountgroup SET Designation = 'Обычная' WHERE Oid = 'cd8ecd6b-1dd8-45ae-9d81-126f65fa7e58';
UPDATE erp_customerdiscountgroup SET Designation = 'Специальная' WHERE Oid = 'da3b9576-cdf8-4b18-95df-646cd70023fe';
