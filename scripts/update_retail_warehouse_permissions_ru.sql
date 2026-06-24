-- Включить меню «Склады» для профиля Владелец (Retail ru seed не содержал эти права).

INSERT OR IGNORE INTO sys_userpermissionitem (Oid, Ord, Code, Token, Designation, PermissionGroup, Disabled) VALUES
('f07fbdec-8a54-4d0f-836c-1a4fc05b1c1c', 3400, 3400, 'BACKOFFICE_MAN_ARTICLESTOCK_CREATE', 'BackOffice :: Управление складом :: Создание', '4c047b35-8fe5-4a4b-ac6e-59c87e0f760a', NULL),
('b9c3c308-8898-4179-b835-38377ba27703', 3500, 3500, 'BACKOFFICE_MAN_WAREHOUSE_CREATE', 'BackOffice :: Управление складами :: Создание', '4c047b35-8fe5-4a4b-ac6e-59c87e0f760a', NULL),
('9bf1d39f-8f9a-45fb-b58c-4f45987395e7', 3510, 3510, 'BACKOFFICE_MAN_WAREHOUSE_DELETE', 'BackOffice :: Управление складами :: Удаление', '4c047b35-8fe5-4a4b-ac6e-59c87e0f760a', NULL),
('a0b3e944-c9f8-459c-8b4b-dfd24b15f160', 3520, 3520, 'BACKOFFICE_MAN_WAREHOUSE_EDIT', 'BackOffice :: Управление складами :: Редактирование', '4c047b35-8fe5-4a4b-ac6e-59c87e0f760a', NULL),
('ae2ab865-365c-4bc0-82f7-79505f517ffe', 3530, 3530, 'BACKOFFICE_MAN_WAREHOUSE_MENU', 'BackOffice :: Управление складами :: Меню', '4c047b35-8fe5-4a4b-ac6e-59c87e0f760a', NULL),
('083d7c91-72c0-482d-83e0-7c0b327fe8e8', 3540, 3540, 'BACKOFFICE_MAN_WAREHOUSE_VIEW', 'BackOffice :: Управление складами :: Просмотр', '4c047b35-8fe5-4a4b-ac6e-59c87e0f760a', NULL),
('ae3dd7d2-4ea5-4da6-b16a-0c820a6ea274', 3550, 3550, 'BACKOFFICE_MAN_ARTICLEWAREHOUSE_CREATE', 'BackOffice :: Склад/товар :: Создание', '4c047b35-8fe5-4a4b-ac6e-59c87e0f760a', NULL),
('56ea98eb-e0f9-4d10-9bd7-bb37c9b9ac65', 3560, 3560, 'BACKOFFICE_MAN_ARTICLEWAREHOUSE_DELETE', 'BackOffice :: Склад/товар :: Удаление', '4c047b35-8fe5-4a4b-ac6e-59c87e0f760a', NULL),
('e9b23452-976f-48c1-a324-94681bed1868', 3570, 3570, 'BACKOFFICE_MAN_ARTICLEWAREHOUSE_EDIT', 'BackOffice :: Склад/товар :: Редактирование', '4c047b35-8fe5-4a4b-ac6e-59c87e0f760a', NULL),
('8028840b-5e4b-4f04-8816-23ea67b2c2f4', 3580, 3580, 'BACKOFFICE_MAN_ARTICLEWAREHOUSE_MENU', 'BackOffice :: Склад/товар :: Меню', '4c047b35-8fe5-4a4b-ac6e-59c87e0f760a', NULL),
('e1ab4485-0909-4c0b-9e62-b148febeedb4', 3590, 3590, 'BACKOFFICE_MAN_ARTICLEWAREHOUSE_VIEW', 'BackOffice :: Склад/товар :: Просмотр', '4c047b35-8fe5-4a4b-ac6e-59c87e0f760a', NULL),
('061e7ff2-418c-4270-9292-e3b0b457f077', 4000, 4000, 'REPORT_LIST_STOCK_WAREHOUSE', 'Отчёт :: Запасы на складе', '4c047b35-8fe5-4a4b-ac6e-59c87e0f760a', NULL),
('2e71e645-4a96-4673-9680-eff3aeedf5d3', 4010, 4010, 'REPORT_LIST_STOCK_ARTICLE', 'Отчёт :: Запасы по товару', '4c047b35-8fe5-4a4b-ac6e-59c87e0f760a', NULL),
('d59f992c-310e-4fb6-afaa-47c6ad8c0b27', 4020, 4020, 'REPORT_LIST_STOCK_SUPPLIER', 'Отчёт :: Запасы по поставщику', '4c047b35-8fe5-4a4b-ac6e-59c87e0f760a', NULL);

INSERT OR IGNORE INTO sys_userpermissionprofile (Oid, Granted, userprofile, PermissionItem) VALUES
('6cbb4f99-a43b-4da3-907b-8941152b72b3', 1, '1626e21f-75e6-429e-b0ac-edb755e733c2', 'f07fbdec-8a54-4d0f-836c-1a4fc05b1c1c'),
('7bdcdfdc-6bca-4789-aaff-7287f656e3a4', 1, '1626e21f-75e6-429e-b0ac-edb755e733c2', 'b9c3c308-8898-4179-b835-38377ba27703'),
('8f75f053-ff2f-47f5-845b-09768fad4fe7', 1, '1626e21f-75e6-429e-b0ac-edb755e733c2', '9bf1d39f-8f9a-45fb-b58c-4f45987395e7'),
('a082b301-be75-42df-badb-d0460ff58356', 1, '1626e21f-75e6-429e-b0ac-edb755e733c2', 'a0b3e944-c9f8-459c-8b4b-dfd24b15f160'),
('0acb1ff2-7901-4f5a-abd0-d0517860b8cd', 1, '1626e21f-75e6-429e-b0ac-edb755e733c2', 'ae2ab865-365c-4bc0-82f7-79505f517ffe'),
('97b6fbce-53ba-45b9-ae1c-08805338d16f', 1, '1626e21f-75e6-429e-b0ac-edb755e733c2', '083d7c91-72c0-482d-83e0-7c0b327fe8e8'),
('5632906e-e0fd-44b5-8b05-a39cb5b67121', 1, '1626e21f-75e6-429e-b0ac-edb755e733c2', 'ae3dd7d2-4ea5-4da6-b16a-0c820a6ea274'),
('2d77ada6-e406-4e30-ad94-e85e984cbceb', 1, '1626e21f-75e6-429e-b0ac-edb755e733c2', '56ea98eb-e0f9-4d10-9bd7-bb37c9b9ac65'),
('0698adc9-2f35-47ec-ac7b-eedf43b21998', 1, '1626e21f-75e6-429e-b0ac-edb755e733c2', 'e9b23452-976f-48c1-a324-94681bed1868'),
('95cbf173-c5bf-4424-8234-ac1f47f96fce', 1, '1626e21f-75e6-429e-b0ac-edb755e733c2', '8028840b-5e4b-4f04-8816-23ea67b2c2f4'),
('18d65246-60c1-4b27-9240-41bf4d0bf7a3', 1, '1626e21f-75e6-429e-b0ac-edb755e733c2', 'e1ab4485-0909-4c0b-9e62-b148febeedb4'),
('fe5dc800-cbb7-4e7b-8bf6-9825adc7889b', 1, '1626e21f-75e6-429e-b0ac-edb755e733c2', '061e7ff2-418c-4270-9292-e3b0b457f077'),
('f524fc77-238a-446a-86bf-c08fecd7c8d4', 1, '1626e21f-75e6-429e-b0ac-edb755e733c2', '2e71e645-4a96-4673-9680-eff3aeedf5d3'),
('4f22a693-ca3d-42ca-b590-1addc91857f6', 1, '1626e21f-75e6-429e-b0ac-edb755e733c2', 'd59f992c-310e-4fb6-afaa-47c6ad8c0b27');

-- Демо-склад (если ещё не создан)
INSERT OR IGNORE INTO fin_warehouse (Oid, Ord, Code, Designation, IsDefault, Disabled) VALUES
('4f5f33a7-7717-49cd-8687-5dc302a0c3cb', 10, 10, 'Склад 1', 1, 0);
INSERT OR IGNORE INTO fin_warehouselocation (Oid, Ord, Code, Designation, Warehouse, Disabled) VALUES
('a12a472b-5f32-4c7a-a648-03072560ffc8', 10, 10, 'Ячейка 1', '4f5f33a7-7717-49cd-8687-5dc302a0c3cb', 0);
