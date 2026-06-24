-- Apply Russian names for payment conditions and payment methods (existing database).

-- Условия оплаты
UPDATE fin_configurationpaymentcondition SET Designation = 'Оплата в течение 10 дней' WHERE Oid = '989e65f9-ea5f-47c1-8505-1c0038e9a552';
UPDATE fin_configurationpaymentcondition SET Designation = 'Оплата в течение 15 дней' WHERE Oid = '198235e4-12e3-42ad-b6fb-2675b5baeac2';
UPDATE fin_configurationpaymentcondition SET Designation = 'Оплата в течение 30 дней' WHERE Oid = '3464045c-9776-48f8-83ad-9bb741526965';
UPDATE fin_configurationpaymentcondition SET Designation = 'Скидка 2% за 10 дней, иначе 30' WHERE Oid = 'bb487817-8819-4fdd-a3ea-b302f32a4ce9';
UPDATE fin_configurationpaymentcondition SET Designation = 'Оплата в рассрочку' WHERE Oid = 'c07a5c41-37b2-4bf3-9469-5faf1799a89f';
UPDATE fin_configurationpaymentcondition SET Designation = 'Оплата при доставке' WHERE Oid = '27c320aa-6c51-4a8e-94cd-c7e07a3b5d66';
UPDATE fin_configurationpaymentcondition SET Designation = 'Оплата при заказе' WHERE Oid = '10007044-2ad3-47a1-812c-d3f91203e50e';
UPDATE fin_configurationpaymentcondition SET Designation = 'Предоплата' WHERE Oid = 'cf94d207-e4c1-4f7b-913e-eaf3df60bc88';

-- Способы оплаты
UPDATE fin_configurationpaymentmethod SET Designation = 'Банковский чек' WHERE Oid = 'cd9a472a-b495-4d10-9e22-291085185d2a';
UPDATE fin_configurationpaymentmethod SET Designation = 'Банкомат' WHERE Oid = '39ddd898-3be3-4d74-bfd2-5163ebeb8f21';
UPDATE fin_configurationpaymentmethod SET Designation = 'Прочее' WHERE Oid = '194d38bd-a54a-42f0-bf60-254e9a62424b';
UPDATE fin_configurationpaymentmethod SET Designation = 'Банковский перевод' WHERE Oid = '4edec9ca-21a9-4423-ae0c-798508c91899';
UPDATE fin_configurationpaymentmethod SET Designation = 'Оплата Visa' WHERE Oid = '536ad245-7459-4462-9bca-1f29d3df31ef';
UPDATE fin_configurationpaymentmethod SET Designation = 'Оплата в кредит' WHERE Oid = '6db009fd-6729-4353-a4d0-d599c4c19297';
UPDATE fin_configurationpaymentmethod SET Designation = 'Карта клиента' WHERE Oid = '18109fb6-8117-4816-98b8-51b0326582e3';
