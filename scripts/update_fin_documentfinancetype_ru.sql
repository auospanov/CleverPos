-- Apply Russian names for fiscal document types (existing database).
UPDATE fin_documentfinancetype SET Designation = 'Счет-фактура' WHERE Oid = '7af04618-74a6-42a3-aaba-454b7076f5a6';
UPDATE fin_documentfinancetype SET Designation = 'Счет-фактура (бланк)' WHERE Oid = 'f8878cf5-0f88-4270-8a55-1fc2488d81a2';
UPDATE fin_documentfinancetype SET Designation = 'Квитанция (упрощенная)' WHERE Oid = '2c69b109-318a-4375-a573-28e5984b6503';
UPDATE fin_documentfinancetype SET Designation = 'Квитанция' WHERE Oid = '09b6aa6e-dc0e-41fd-8dbe-8678a3d11cbc';
UPDATE fin_documentfinancetype SET Designation = 'Поручение на списание' WHERE Oid = '3942d940-ed13-4a62-a352-97f1ce006d8a';
UPDATE fin_documentfinancetype SET Designation = 'Кредит-нота' WHERE Oid = 'fa924162-beed-4f2f-938d-919deafb7d47';
UPDATE fin_documentfinancetype SET Designation = 'Товарная накладная' WHERE Oid = '95f6a472-1b12-43aa-a215-a4b406b18924';
UPDATE fin_documentfinancetype SET Designation = 'Транспортная накладная' WHERE Oid = '96bcf534-0dab-48bb-a69e-166e81ae6f7b';
UPDATE fin_documentfinancetype SET Designation = 'Учет основных средств' WHERE Oid = 'f8e96786-fed8-4143-be9e-b03c3a984a2c';
UPDATE fin_documentfinancetype SET Designation = 'Консигнационная накладная' WHERE Oid = '63d8eb04-983c-4524-96de-979a240b362c';
UPDATE fin_documentfinancetype SET Designation = 'Возвратная накладная' WHERE Oid = 'f03d2788-bed6-41ab-8d44-100039103e83';
UPDATE fin_documentfinancetype SET Designation = 'Счет' WHERE Oid = 'afed98d3-eae7-43a7-a7be-515753594c8f';
UPDATE fin_documentfinancetype SET Designation = 'Консигнационный счет-фактура' WHERE Oid = 'b8554d36-642a-4083-b608-8f1da35f0fec';
UPDATE fin_documentfinancetype SET Designation = 'Запрос котировки/предложения' WHERE Oid = '005ac531-31a1-44bb-9346-058f9c9ad01a';
UPDATE fin_documentfinancetype SET Designation = 'Проформа-счет' WHERE Oid = '6f4249d0-4aaf-4711-814f-7f9533a1ef7f';
UPDATE fin_documentfinancetype SET Designation = 'Товарный чек' WHERE Oid = 'a009168d-fed1-4f52-b9e3-77e280b18ff5';
UPDATE fin_documentfinancetype SET Designation = 'Оплата в кредит' WHERE Oid = '235f06f3-5ec3-4e13-977b-325614b07e35';
