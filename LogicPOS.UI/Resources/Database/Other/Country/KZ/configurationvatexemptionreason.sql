-- Причины освобождения от НДС (Казахстан);
UPDATE fin_configurationvatexemptionreason SET Designation = 'Без НДС', Acronym = 'KZ01', StandardApplicable = 'НК РК ст. 394', Disabled = NULL WHERE Oid = 'f60f97c0-390e-4d76-90d7-204b6ea57949';
UPDATE fin_configurationvatexemptionreason SET Designation = 'Освобождение по НК РК', Acronym = 'KZ02', StandardApplicable = 'НК РК ст. 394-407', Disabled = NULL WHERE Oid = '8311ce58-50ee-4115-9cf9-dbca86538fdd';
UPDATE fin_configurationvatexemptionreason SET Designation = 'Экспортные операции', Acronym = 'KZ03', StandardApplicable = 'НК РК ст. 387', Disabled = NULL WHERE Oid = 'dac53af1-fc00-477d-b82c-4cc4bde935b3';
UPDATE fin_configurationvatexemptionreason SET Designation = 'Медицинские услуги', Acronym = 'KZ04', StandardApplicable = 'НК РК ст. 396', Disabled = NULL WHERE Oid = 'f4ce1854-0580-4248-bb0f-26a562661710';
UPDATE fin_configurationvatexemptionreason SET Designation = 'Образовательные услуги', Acronym = 'KZ05', StandardApplicable = 'НК РК ст. 396', Disabled = NULL WHERE Oid = 'a5b04ac5-2ded-4071-9586-a7d435b1ace5';
UPDATE fin_configurationvatexemptionreason SET Designation = 'Финансовые услуги', Acronym = 'KZ06', StandardApplicable = 'НК РК ст. 396', Disabled = NULL WHERE Oid = '1c7c52ec-7eb5-44d0-a130-da8a47a069e3';
UPDATE fin_configurationvatexemptionreason SET UpdatedBy = '090c5684-52ba-4d7a-8bc3-a00320ef503d', CreatedAt = '2014-02-28 14:02:28', UpdatedAt = '2019-03-11 23:16:18';
