-- Apply Russian names for price types (existing database).
UPDATE fin_configurationpricetype SET Designation = 'Обычный' WHERE Oid = 'cf17a218-b687-4b82-a8f4-0905594ac1f5';

-- Retail / wholesale mode
UPDATE fin_configurationpricetype SET Designation = 'Перепродажа' WHERE Oid = 'f837476d-1b62-447f-80fb-b8cbfe5e9c2b' AND Designation IN ('Resale', 'Revenda', 'Público');
UPDATE fin_configurationpricetype SET Designation = 'Партнёр' WHERE Oid = 'f42bc933-49e9-46bc-aee2-d1f17c6ea012' AND Designation IN ('Partner', 'Parceiro', 'Esplanada');
UPDATE fin_configurationpricetype SET Designation = 'Продавец' WHERE Oid = '4d3c1925-64ac-4ce9-98a8-f9fa17b18832' AND Designation IN ('Salesman', 'Vendedor', 'Especial');
UPDATE fin_configurationpricetype SET Designation = 'Экспорт' WHERE Oid = 'a6e20c09-5b4e-49ed-9565-875ae2a70590' AND Designation IN ('Export', 'Exportação');

-- Restaurant / default mode
UPDATE fin_configurationpricetype SET Designation = 'Бар' WHERE Oid = 'f837476d-1b62-447f-80fb-b8cbfe5e9c2b' AND Designation IN ('Bar Counter', 'Balcão', 'Normal');
UPDATE fin_configurationpricetype SET Designation = 'Терраса' WHERE Oid = 'f42bc933-49e9-46bc-aee2-d1f17c6ea012' AND Designation IN ('Patio');
UPDATE fin_configurationpricetype SET Designation = 'Специальный' WHERE Oid = '4d3c1925-64ac-4ce9-98a8-f9fa17b18832' AND Designation IN ('Special');
UPDATE fin_configurationpricetype SET Designation = 'Питание персонала' WHERE Oid = 'a6e20c09-5b4e-49ed-9565-875ae2a70590' AND Designation IN ('Staff Consumption');
