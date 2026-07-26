-- Kaspi Smart POS terminal (KZ). Upsert-safe for re-runs on existing DBs.
INSERT INTO sys_configurationpaymentterminal (Oid,Ord,Code,Designation,Brand,Host,Port,PosClientName,UseHttps,Disabled)
SELECT '7f8e9d0c-1b2a-4c3d-8e7f-6a5b4c3d2e1f',10,10,'Kaspi Smart POS','KASPI','192.168.1.249',8080,'CleverPos-1',0,0
WHERE NOT EXISTS (SELECT 1 FROM sys_configurationpaymentterminal WHERE Oid = '7f8e9d0c-1b2a-4c3d-8e7f-6a5b4c3d2e1f');

UPDATE sys_configurationpaymentterminal
SET Host = '192.168.1.249', Port = 8080, Brand = 'KASPI', Disabled = 0, Designation = 'Kaspi Smart POS', PosClientName = COALESCE(NULLIF(PosClientName, ''), 'CleverPos-1')
WHERE Oid = '7f8e9d0c-1b2a-4c3d-8e7f-6a5b4c3d2e1f';
