-- Единицы измерения
UPDATE cfg_configurationunitmeasure SET Designation = 'Штука', Acronym = 'шт.' WHERE Oid = '4c81aa20-98ec-4497-b740-165cdb5fa395';
UPDATE cfg_configurationunitmeasure SET Designation = 'Килограмм', Acronym = 'кг' WHERE Oid = 'd04d07e2-671c-4555-a177-da7634419a9b';
UPDATE cfg_configurationunitmeasure SET Designation = 'Литр', Acronym = 'л' WHERE Oid = '4bbdb44a-c15a-4133-9eff-bbb6ce179d61';
UPDATE cfg_configurationunitmeasure SET Designation = 'Час', Acronym = 'ч' WHERE Oid = '63f94a2e-30ae-4dae-bf2e-71e7dc49b0ff';
UPDATE cfg_configurationunitmeasure SET Designation = 'Метр', Acronym = 'м' WHERE Oid = 'd9ff39ae-58ce-4c86-a267-899b11373380';
UPDATE cfg_configurationunitmeasure SET Designation = 'Квадратный метр', Acronym = 'м2' WHERE Oid = 'db6bf60c-c2b2-4130-b092-fbc78ce683fd';
UPDATE cfg_configurationunitmeasure SET Designation = 'Кубический метр', Acronym = 'м3' WHERE Oid = '176429e9-38f2-42ae-8cb6-32c5aa055ac4';

-- Единицы размера
UPDATE cfg_configurationunitsize SET Designation = 'Обычный' WHERE Oid = '18f564aa-7da5-4a1c-9091-8014638b818c';
UPDATE cfg_configurationunitsize SET Designation = 'Малый' WHERE Oid = '4d3e69a5-90dc-4918-848f-4eb7ce7a792e';
UPDATE cfg_configurationunitsize SET Designation = 'Большой' WHERE Oid = '016ba999-1a4d-4933-8ff1-e5945a7652a3';

-- Типы обслуживания (Retail)
UPDATE pos_configurationplacemovementtype SET Designation = 'Обычный' WHERE Oid = '378cef43-82a0-4c2e-a157-4907e52806ef';
UPDATE pos_configurationplacemovementtype SET Designation = 'Перепродажа' WHERE Oid = '9e3d68b5-5aae-459b-969d-dd039b33e8cd';
UPDATE pos_configurationplacemovementtype SET Designation = 'Партнёр' WHERE Oid = '88e92456-cea4-4a32-ad43-9c3aafb3033b';
UPDATE pos_configurationplacemovementtype SET Designation = 'Экспорт' WHERE Oid = 'ab506a3c-4aec-4427-9b71-ce9f0269ce7c';
