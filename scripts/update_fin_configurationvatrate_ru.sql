-- Apply Russian names for fiscal VAT rates (existing database).
UPDATE fin_configurationvatrate SET Designation = 'Стандартная ставка НДС (Мадейра)', TaxDescription = 'Мадейра' WHERE Oid = 'ecd64d02-5249-4303-a35c-c662ffba4844';
UPDATE fin_configurationvatrate SET Designation = 'Промежуточная ставка НДС (Мадейра)', TaxDescription = 'Мадейра' WHERE Oid = 'f0281b91-83d7-482f-bfd8-e52461983136';
UPDATE fin_configurationvatrate SET Designation = 'Льготная ставка НДС (Мадейра)', TaxDescription = 'Мадейра' WHERE Oid = 'b57d85a5-843e-4b84-9660-9124006b9b05';
UPDATE fin_configurationvatrate SET Designation = 'Стандартная ставка НДС (Азорские острова)', TaxDescription = 'Азорские острова' WHERE Oid = '389661c1-05f6-4830-bc06-176e2fdb3dc2';
UPDATE fin_configurationvatrate SET Designation = 'Промежуточная ставка НДС (Азорские острова)', TaxDescription = 'Внес материковые территории' WHERE Oid = '52c6ce3c-9246-4b8b-a143-b84733a074d4';
UPDATE fin_configurationvatrate SET Designation = 'Льготная ставка НДС (внес материковые территории)', TaxDescription = 'Внес материковые территории' WHERE Oid = 'e4478dea-9272-4090-a71a-df775b96c4b3';
UPDATE fin_configurationvatrate SET TaxDescription = 'Материковая часть' WHERE Oid IN ('f73e3b41-4967-48c6-9f9a-260abf2146e1', '7e89eaed-ce56-4565-8eec-98f2e8d004a5');
