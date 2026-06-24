-- Russian names for printer types, printers and templates (existing database).

UPDATE sys_configurationprinterstype SET Designation = 'Термопринтер / Windows' WHERE Oid = 'e7143ea5-391b-46ef-a28d-4843fd7e21ac';
UPDATE sys_configurationprinterstype SET Designation = 'Термопринтер / Linux' WHERE Oid = '3fab75ce-e81f-4488-b0a0-962c9336f3bb';
UPDATE sys_configurationprinterstype SET Designation = 'Термопринтер / Linux / Сеть (Socket)' WHERE Oid = 'faeb45cd-2989-4e92-9907-3038444e4849';
UPDATE sys_configurationprinterstype SET Designation = 'Принтер A4 Windows' WHERE Oid = '4be662e6-67c9-4063-bd6c-574ae4df7f3f';
UPDATE sys_configurationprinterstype SET Designation = 'Принтер A4 Linux' WHERE Oid = '3d38a3c3-667b-4c0c-b487-f18ddd3c8a4a';
UPDATE sys_configurationprinterstype SET Designation = 'Экспорт в PDF' WHERE Oid = 'e5e20cd0-d9d2-443d-9d3f-3478949db30f';

UPDATE sys_configurationprinters SET Designation = 'Принтер A4' WHERE Oid = 'b0c917c7-2ea1-4e08-afa5-4744c19e1c5c';
UPDATE sys_configurationprinters SET Designation = 'Термопринтер (сеть)' WHERE Oid = '7b7243d2-5009-4ac8-a96b-2d0d92aceea8';
UPDATE sys_configurationprinters SET Designation = 'Термопринтер Windows (общий)' WHERE Oid = '9a19e7f7-ae28-429c-901c-0fefff712301';
UPDATE sys_configurationprinters SET Designation = 'Экспорт в PDF' WHERE Oid = '4be24552-4e08-4916-a964-65fdacb523ac';

UPDATE sys_configurationprinterstemplates SET Designation = 'Шаблон печати счетов' WHERE Oid = '4be8cf96-431d-4df0-be1d-c27b1fd12978';
UPDATE sys_configurationprinterstemplates SET Designation = 'Шаблон печати счетов (накладной)' WHERE Oid = 'd6e575ea-0428-4ca1-980c-4d26ccacdece';
UPDATE sys_configurationprinterstemplates SET Designation = 'Шаблон печати квитанций (упрощённый)' WHERE Oid = '441a3dd5-be29-46f7-80a3-5b94a783cad7';
UPDATE sys_configurationprinterstemplates SET Designation = 'Шаблон печати квитанций (модель 2)' WHERE Oid = 'c3b0735f-e588-4234-8fe5-4c780e8913ed';
UPDATE sys_configurationprinterstemplates SET Designation = 'Шаблон печати платёжных требований' WHERE Oid = '9b81c568-01f3-48e4-bc8a-b005f6569078';
UPDATE sys_configurationprinterstemplates SET Designation = 'Шаблон печати кредит-нот' WHERE Oid = '58157193-9644-4089-98e4-d9a30ae1fc65';
UPDATE sys_configurationprinterstemplates SET Designation = 'Шаблон печати накладных' WHERE Oid = 'c7a676a0-1f8e-476c-82ec-bfc11de6e4cf';
UPDATE sys_configurationprinterstemplates SET Designation = 'Шаблон печати транспортных документов' WHERE Oid = 'eb40776e-bcbb-43bb-bd99-44ac7b23ce45';
UPDATE sys_configurationprinterstemplates SET Designation = 'Шаблон движения основных средств' WHERE Oid = 'eee76f2d-0c8d-4d52-b31a-dbe920cb27c3';
UPDATE sys_configurationprinterstemplates SET Designation = 'Шаблон консигнации' WHERE Oid = '20752bc3-2bfa-4845-ac88-fba6ce7d9a80';
UPDATE sys_configurationprinterstemplates SET Designation = 'Шаблон возвратных накладных (модель 2)' WHERE Oid = '1cc56005-acb0-4b24-b77b-72fa838f3fc6';
UPDATE sys_configurationprinterstemplates SET Designation = 'Шаблон возвратных накладных (модель 1)' WHERE Oid = '89157bf8-bee1-4588-8982-624e3952ee6c';
UPDATE sys_configurationprinterstemplates SET Designation = 'Шаблон консигнационного счёта' WHERE Oid = '5a719507-cb44-42b5-bf10-0322c5116a81';
UPDATE sys_configurationprinterstemplates SET Designation = 'Шаблон печати счёта стола' WHERE Oid = 'f6a25476-40b0-46d7-9104-d5db3f50d7f1';
UPDATE sys_configurationprinterstemplates SET Designation = 'Шаблон печати заказов' WHERE Oid = 'a537cad3-ebf4-4df4-bd8d-74209ad226a2';
UPDATE sys_configurationprinterstemplates SET Designation = 'Шаблон печати заказа на товар' WHERE Oid = 'a537cad3-ebf4-4df4-bd8d-28009ad226a2';
UPDATE sys_configurationprinterstemplates SET Designation = 'Шаблон закрытия смены' WHERE Oid = 'f6a25476-40b0-4287-9284-d5db3280d7f1';
UPDATE sys_configurationprinterstemplates SET Designation = 'Шаблон внесения/изъятия наличных' WHERE Oid = 'f6565476-28b0-4287-9284-d5db3280d421';
UPDATE sys_configurationprinterstemplates SET Designation = 'Шаблон печати чека' WHERE Oid = '5409255a-3741-411c-b05b-056cbd470226';
UPDATE sys_configurationprinterstemplates SET Designation = 'Шаблон оплаты в кредит' WHERE Oid = 'adb47395-0adb-40b0-bf02-d15cc35c29ac';
UPDATE sys_configurationprinterstemplates SET Designation = 'Шаблон коммерческого предложения' WHERE Oid = '0f7318de-0f7b-4e37-8327-7a00d7f0bba5';
UPDATE sys_configurationprinterstemplates SET Designation = 'Шаблон проформы' WHERE Oid = 'e317b481-920a-4097-a1e1-4c9f7a211855';
UPDATE sys_configurationprinterstemplates SET Designation = 'Шаблон печати штрихкода 40×30' WHERE Oid = 'b931ef9c-75cf-4e2e-94ed-b67a22f50cda';
UPDATE sys_configurationprinterstemplates SET Designation = 'Шаблон печати штрихкода 100×50' WHERE Oid = '577c83c4-2469-4d15-aae8-770f34782d57';
