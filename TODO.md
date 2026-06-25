# CleverPos / Kazakhstan — план работ

Чеклист для продолжения на другом компьютере. Отмечайте `[x]` по мере выполнения.

**Репозиторий:** `C:\Projects\CleverPos`  
**Ветка:** проверьте `git status` и `git branch` после клонирования  
**Документация НКТ:** https://nationalcatalog.kz/gwp/docs  
**Подробный анализ** (розница, склады, НКТ): [`docs/KZ-RETAIL-WAREHOUSE-NKT-ANALYSIS.md`](docs/KZ-RETAIL-WAREHOUSE-NKT-ANALYSIS.md)

---

## Уже сделано (не трогать без необходимости)

- [x] **Фаза A — ru-RU + KZ в БД:** SQL в `LogicPOS.UI/Resources/Database/Other/Country/KZ/`, демо-данные `Data/**/ru/`, цены ×400 KZT
- [x] **App.config:** `cultureFinancialRules=ru-RU`, отключены AT/SAF-T для KZ, `appUseParkingTicketModule=false`
- [x] **Культура:** `LogicPOSApp.cs` — потоковая культура из настроек (не захардкожен `ru-RU`)
- [x] **Локализация:** `Resx.ru-RU.resx` — «тиын» в сумме прописью
- [x] **Справочник стран на русском:** `scripts/countries_ru.json`, `scripts/translate_countries_ru.py`, все `Data/**/ru/databasedata.sql`; авто-патч существующей БД при `ru-RU` (`DataLayer.ApplyRussianCountryNamesIfNeeded`)
- [x] **Скрипт:** `scripts/apply_kz_ru_phase_a.py`

---

## Фаза B — Конфиг и первый запуск на новом ПК

- [ ] Клонировать репозиторий, открыть `LogicPOS.sln` в Visual Studio 2019
- [ ] Установить GTK# runtime (`others/windowsruntime/gtk-sharp-2.12.22.msi`)
- [ ] Rebuild Solution (платформа как в solution, обычно x86)
- [ ] Проверить `LogicPOS.UI/App.config`:
  - [ ] `customCultureResourceDefinition` = `ru-RU`
  - [ ] `cultureFinancialRules` = `ru-RU`
  - [ ] `appOperationModeToken` = `ClothingStore` (или свой тип магазина)
  - [ ] `useDatabaseDataDemo` = `true` для теста
- [ ] **Исправить НКТ в App.config** (сейчас ошибочные URL):
  - [ ] Удалить/не использовать `stg.nct.kz` и `nct.kz` — в официальной доке staging нет
  - [ ] Базовый URL: `https://nationalcatalog.kz`
  - [ ] Пути API: `/portal/api/v1/products/requests/...`, `/portal/api/v1/dictionaries/...`
  - [ ] Заголовок авторизации: `X-API-KEY`
  - [ ] Ключ только в `App.config`, не в README; при утечке — перевыпустить ключ
- [ ] Удалить `logicposdb.db` (если есть) и запустить POS с чистой БД
- [ ] Мастер настройки: страна **Казахстан**, валюта **KZT**, BIN 12 цифр

---

## Фаза C — Штрихкоды и этикетки (перекупщик)

**Модель:** один SKU = одно значение в `fin_article.BarCode` = то же на этикетке = `gtin` в НКТ.

- [ ] Заполнить `BarCode` у тестовых товаров (EAN-13, префикс 487 или свой пул GS1)
- [ ] Проверить: EAN валидный (13 цифр + контрольная цифра)
- [ ] Договориться о формате хранения: всегда 13 цифр (с ведущими нулями)
- [ ] **Печать этикеток:** сейчас шаблон `BarCodeTemplate_40x30.frx` печатает **Code128 + SerialNumber** (склад), а не `BarCode`
  - [ ] Доработать шаблон(ы) `LogicPOS.UI/Resources/Reports/UserReports/BarCodeTemplate_*.frx` — кодировать поле **`BarCode`** (EAN-13)
  - [ ] Либо отдельный шаблон «этикетка товара» vs «серийник склада»
  - [ ] Печать названия/артикула с этикетки (`Designation`, `Code`)
- [ ] Опционально: генератор EAN при создании товара (следующий номер из пула)
- [ ] `CodeDealer` — хранить EAN поставщика справочно, на кассе не использовать

**Поиск на кассе** (`TicketList.InsertOrUpdate`):
1. `fin_article.BarCode = строка со сканера`
2. иначе `fin_article.Code = строка`

---

## Фаза D — CleverApp + касса (проверка)

- [ ] POS запущен, касса открыта, **выбран заказ/стол** (иначе — предупреждение)
- [ ] CleverApp находит сервер (UDP 8888, HTTP 5000)
- [ ] Скан EAN с этикетки → «Отправить на сервер» → позиция в чеке
- [ ] USB-сканер — та же логика через `ProcessScannedBarcode`
- [ ] Несуществующий код → «Введенный код не существует в системе»
- [ ] Сравнить строку с телефона и с USB: должна совпадать с `BarCode` в карточке

**Ключевые файлы:**
- `CleverApp/LiveBarcodeScanPage.xaml.cs` — живая камера (1D: EAN-13, Code128…)
- `CleverApp/Services/BarcodeSenderService.cs` — POST `/barcode`
- `LogicPOS.UI/LogicPOSApp.cs` — HTTP-сервер порта 5000
- `LogicPOS.UI/Components/POS/Windows/PosMainWindow/PosMainWindow.Functions.cs` — `ProcessScannedBarcode`

---

## Фаза E — Национальный каталог (НКТ)

Только при `ConfigurationSystemCountry.Code2 == "KZ"` и `nationalCatalogEnabled=true`.  
**Анализ API, маппинг, архитектура:** [`docs/KZ-RETAIL-WAREHOUSE-NKT-ANALYSIS.md`](docs/KZ-RETAIL-WAREHOUSE-NKT-ANALYSIS.md) §3.

### E.1 — Конфиг и клиент

- [ ] `App.config`: `nationalCatalogEnabled`, `nationalCatalogApiKey`, `nationalCatalogBaseUrl=https://nationalcatalog.kz`
- [ ] Проект `LogicPOS.NationalCatalog` (или `LogicPOS.Integration.NationalCatalog`)
- [ ] HTTP-клиент: заголовок `X-API-KEY`, обработка 401/422/429
- [ ] Тест: `POST /portal/api/v1/products/requests` с тестовым ключом

### E.2 — Данные и маппинг

- [ ] Таблица `fin_articlenationalcatalog` (Article, RequestId, Status, Oktru, Gtin, LastError, UpdatedAt)
- [ ] Маппинг: `BarCode`→`gtin`, `Designation`→`name_ru`, `Code`→`article`, `name_kk` (копия или поле)
- [ ] Поле/справочник **ОКТРУ** у товара (обязательно для заявки)

### E.3 — UI (BackOffice)

- [ ] `DialogArticle`: кнопки «Отправить в НКТ», «Статус», «Повторить» (видимы только KZ + enabled)
- [ ] `DialogNationalCatalogOktru` — дерево из `/portal/api/v1/dictionaries/...` (кэш)
- [ ] Отображение статуса заявки (`new` … `completed`)

### E.4 — Workflow заявки

- [ ] POST draft → PUT attributes → PUT moderation → GET status (опрос) → PUT publish
- [ ] MVP-атрибуты для одежды: `oktru`, `name_ru`, `name_kk`, `gtin`, `article`, `country=KZ`
- [ ] `GET .../requests/attributes?oktru=` — подбор обязательных полей по категории
- [ ] Повтор при `underRevision`; обработка `existingProductSelected`

### E.5 — Не в MVP

- [ ] Импорт товаров из НКТ в CleverPos
- [ ] Универсальный редактор всех атрибутов НКТ

**Не делать:** интеграцию со `stg.nct.kz` — нет в официальной документации.

---

## Фаза H — Склад (опционально, не блокер для кассы)

**Не нужен** для сценария «один штрихкод на SKU → скан → оплата».  
**Анализ схемы, плагин, оценки:** [`docs/KZ-RETAIL-WAREHOUSE-NKT-ANALYSIS.md`](docs/KZ-RETAIL-WAREHOUSE-NKT-ANALYSIS.md) §2.

### H.1 — MVP модуля `IStockManagementModule`

- [ ] Класс `StockManagementModule` (в `LogicPOS.Modules` или `*Plugin.dll` в `plugins/`)
- [ ] Регистрация в `Program.cs` или через `PluginLoader`
- [ ] `Add`: `fin_articlestock` + обновление `fin_articlewarehouse` + `article.Accounting`
- [ ] Склад по умолчанию: `fin_warehouse.IsDefault`
- [ ] Списание при продаже / возврат при отмене документа (`StockMode`)

### H.2 — Позже

- [ ] Серийные номера, составные товары
- [ ] Опционально: `Warehouse`/`Location` в `fin_articlestock` (аудит в журнале)
- [ ] Колонка «склад» в `TreeViewArticleStock`

**UI форм новых не требует** — `DialogArticleStock`, `DialogAddArticleStock` уже есть.

---

## Фаза F — Казахстан: фискализация и отчётность (отдельный большой блок)

Пока **не реализовано** — только заглушки в config (`kazakhstanEsf/Fiscal/Kgd = false`).

- [ ] ИС **ЭСФ** (электронные счета-фактуры)
- [ ] Фискальный регистратор **KKM / ОФД**
- [ ] Отчётность **КГД**
- [ ] SAF-T/AT для KZ уже отключены в SQL — меню скрыто при `cultureFinancialRules != PT/AO`

---

## Фаза G — Опциональные улучшения

- [x] Справочник стран на русском (seed + миграция для существующей БД)
- [ ] Нормализация EAN при скане (ведущий `0`, 12 vs 13 цифр) перед поиском в БД
- [ ] Убрать захардкоженный русский текст в `ShowMobileBarcodeReceived` («Откройте кассу…») → в `Resx.ru-RU.resx`
- [ ] Демо-артикулы: проставить `BarCode` в `Demos/*/ru/` SQL
- [ ] README: ссылка на этот `TODO.md` (по желанию)

---

## Справочник: важные Oid и пути

| Сущность | Oid / путь |
|----------|------------|
| Казахстан (страна) | `be4d3781-dfa0-40fb-ab06-1debf5bf0edd` |
| KZT | `3f8e1a2b-4c5d-6e7f-8a9b-0c1d2e3f4a5b` |
| НДС 12% KZ (default) | `cee00590-7317-41b8-af46-66560401096b` |
| SQL страны KZ | `LogicPOS.UI/Resources/Database/Other/Country/KZ/` |
| Seed ru | `LogicPOS.UI/Resources/Database/Data/{Theme}/ru/databasedata.sql` |
| Демо товары | `LogicPOS.UI/Resources/Database/Demos/*/ru/` |

---

## Тест-чеклист перед релизом магазину

1. [ ] Чистая БД, ru-RU, Kazakhstan, KZT, демо или реальные товары
2. [ ] Товар с `BarCode` → USB-скан → в чеке
3. [ ] Тот же товар → CleverApp → в чеке
4. [ ] Этикетка напечатана из системы → скан с телефона совпадает с `BarCode`
5. [ ] НКТ: черновик → модерация → статус (если фаза E готова)
6. [ ] Чек, оплата, печать (без PT/AU fiscal — ожидаемо ограничено)

---

## Git на другом компьютере

```bash
git clone <url-репозитория> CleverPos
cd CleverPos
git status
git log -5 --oneline
```

Коммиты создавать только когда явно нужно. Перед работой убедиться, что перенесены незакоммиченные изменения (`git diff`, `git stash` или push ветки).

---

## Порядок приоритетов (кратко)

1. **B** — исправить App.config, проверить запуск KZ/ru-RU  
2. **C** — `BarCode` + печать этикеток с EAN  
3. **D** — прогнать CleverApp + кассу  
4. **E** — интеграция НКТ (после C: `gtin` = `BarCode`)  
5. **H** — склад MVP (позже, не блокер розницы)  
6. **F** — ЭСФ/KKM/КГД (позже)

Полный анализ: [`docs/KZ-RETAIL-WAREHOUSE-NKT-ANALYSIS.md`](docs/KZ-RETAIL-WAREHOUSE-NKT-ANALYSIS.md)

Шаблон BarCodeTemplate_*.frx — кодировать fin_article.BarCode (EAN-13), а не SerialNumber.
Убрать зависимость печати от плагина SoftwareVendor.
Опционально: кнопка «Печать этикетки» прямо из карточки товара без склада.