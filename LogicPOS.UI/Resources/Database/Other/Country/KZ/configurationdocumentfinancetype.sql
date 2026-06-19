-- Отключение португальской фискализации (AT/SAF-T) для Казахстана;
UPDATE fin_documentfinancetype SET WsAtDocument = 0, SaftAuditFile = 0;
UPDATE fin_documentfinancetype SET UpdatedBy = '090c5684-52ba-4d7a-8bc3-a00320ef503d', UpdatedAt = '2019-03-11 23:16:18';
