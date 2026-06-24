-- Apply Russian names for places and service types (Retail theme, existing database).

-- Места
UPDATE pos_configurationplace SET Designation = 'Обычный' WHERE Oid = '5d1f314a-9f86-4cb8-95b7-73149a1b2ab9';
UPDATE pos_configurationplace SET Designation = 'Перепродажа' WHERE Oid = 'dbb86cc4-46f5-4202-b24d-32d5b0d3f0b0';
UPDATE pos_configurationplace SET Designation = 'Партнёр' WHERE Oid = 'f8c8fa99-751e-423f-96ac-1f4fe0dcbbec';

-- Типы обслуживания
UPDATE pos_configurationplacemovementtype SET Designation = 'Обычный' WHERE Oid = '378cef43-82a0-4c2e-a157-4907e52806ef';
UPDATE pos_configurationplacemovementtype SET Designation = 'Перепродажа' WHERE Oid = '9e3d68b5-5aae-459b-969d-dd039b33e8cd';
UPDATE pos_configurationplacemovementtype SET Designation = 'Партнёр' WHERE Oid = '88e92456-cea4-4a32-ad43-9c3aafb3033b';
UPDATE pos_configurationplacemovementtype SET Designation = 'Экспорт' WHERE Oid = 'ab506a3c-4aec-4427-9b71-ce9f0269ce7c';

-- Столы/заказы (Retail)
UPDATE pos_configurationplacetable SET Designation = 'Заказ №1' WHERE Oid = '63bf27d9-d13e-46df-ac4e-5c8dce63f31f';
UPDATE pos_configurationplacetable SET Designation = 'Заказ №2' WHERE Oid = 'e4712e7a-5f0a-4acc-ad5c-420114b9fe12';
UPDATE pos_configurationplacetable SET Designation = 'Заказ №3' WHERE Oid = 'd1243b8c-968b-4963-88a7-90250d355382';
UPDATE pos_configurationplacetable SET Designation = 'Заказ №4' WHERE Oid = '8f569aad-92b3-4ecc-ad45-3321799fef4b';
UPDATE pos_configurationplacetable SET Designation = 'Заказ №5' WHERE Oid = 'ed99f917-def5-474a-b454-6de90eb51082';
UPDATE pos_configurationplacetable SET Designation = 'Перепродажа №1' WHERE Oid = '1f1bf1af-a339-40fb-98c3-f54428ba43d9';
UPDATE pos_configurationplacetable SET Designation = 'Перепродажа №2' WHERE Oid = '7c54bc86-3116-4587-9ab0-7ed6f5e75527';
UPDATE pos_configurationplacetable SET Designation = 'Партнёр №1' WHERE Oid = 'fb222ffe-0e10-46cf-8caf-ac84643f251c';
UPDATE pos_configurationplacetable SET Designation = 'Партнёр №2' WHERE Oid = 'aca21c5e-139a-4069-9000-87e3b8dfe624';
