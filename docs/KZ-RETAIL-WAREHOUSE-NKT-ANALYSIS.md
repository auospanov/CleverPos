# CleverPos / Kazakhstan — анализ: розница, склады, НКТ

Документ фиксирует решения и объём работ **до реализации**. Чеклист задач — в корневом [`TODO.md`](../TODO.md).

**Дата фиксации:** 2025-06-08  
**Документация НКТ:** https://nationalcatalog.kz/gwp/docs  
**API-ключ НКТ:** `nationalCatalogApiKey` в `LogicPOS.UI/App.config` (получить в [личном кабинете](https://nationalcatalog.kz/personal-account/api-keys)). **Не хранить ключи в git и в этом файле.**

---

## 1. Бизнес-модель магазина (целевой сценарий)

- Магазин **вещей** (одежда и т.п.), Retail / `ClothingStore`.
- **Один штрихкод на артикул** (все одинаковые куртки M красные → один EAN). Уникальный код на каждую вещь **не нужен**.
- Наклейка с штрихкодом → скан на кассе (USB или CleverApp) → строка в заказе → оплата.
- Параллельно — **регистрация товара в Национальном каталоге (НКТ)** с тем же GTIN.

### Цепочка данных

```
fin_article.BarCode  =  код на наклейке  =  gtin в НКТ
fin_article.Code     =  внутренний артикул (в НКТ: article)
fin_article.Designation = name_ru в НКТ
```

### Размеры и цвета

Один артикул CleverPos = одна карточка `fin_article`. Разные размер/цвет → **разные товары** с **разными** `BarCode`. Повторный скан одного кода → **+1 шт.** в заказе.

### Что для запуска магазина **не блокирует**

| Компонент | Нужен для «скан → оплата»? |
|-----------|----------------------------|
| Модуль склада (`IStockManagementModule`) | **Нет** |
| Серийные номера | **Нет** |
| Несколько складов / ячейки | **Нет** |
| Интеграция НКТ | **Нет** (нужна для учёта в НКТ, не для кассы) |

### Что нужно для кассы

1. Карточки товаров с полем **`BarCode`** (EAN-13).
2. USB-сканер на терминале или CleverApp → HTTP `/barcode`.
3. **Открытый заказ/стол** до скана.
4. Retail-цены (`Price1`, НДС KZ).

**Поиск на кассе** (`TicketList.InsertOrUpdate`):

1. `fin_article.BarCode = строка со сканера`
2. иначе `fin_article.Code = строка`

**Ключевые файлы:**

- `LogicPOS.UI/Components/Widgets/TreeView/TicketList.cs`
- `LogicPOS.UI/Components/POS/Windows/PosMainWindow/PosMainWindow.Functions.cs` — `ProcessScannedBarcode`
- `CleverApp/LiveBarcodeScanPage.xaml.cs`, `BarcodeSenderService.cs`
- `LogicPOS.UI/LogicPOSApp.cs` — HTTP-сервер

---

## 2. Складской учёт — анализ

### 2.1. Две модели в БД (уже есть)

| Таблица | Назначение | Склад в записи? |
|---------|------------|-----------------|
| `fin_articlestock` | Журнал движений (+/−), остаток = `SUM(Quantity)` | **Нет** (нет FK Warehouse/Location) |
| `fin_articlewarehouse` | Остаток: товар + склад + ячейка + серийник | **Да** |

Связи в схеме SQLite/MySQL **достаточны** для полного склада:

- `fin_warehouse` ↔ `fin_warehouselocation`
- `fin_articlewarehouse` → Article, Warehouse, Location, ArticleSerialNumber
- `fin_articleserialnumber` → Article, ArticleWarehouse, StockMovimentIn/Out
- Представления: `view_articlestockmovement`, `view_articlestockwarehouse`, `view_articlestock`, `view_articlestocksupplier`

### 2.2. Два «замка» в коде

| Условие | Откуда | Что открывает |
|---------|--------|---------------|
| `LicenseSettings.LicenseModuleStocks` | Лицензия `logicpos_Module_Stocks` | Расширенные складские отчёты |
| `ModulesSettings.StockManagementModule` | DLL `*Plugin.dll` с `IStockManagementModule` в папке `plugins` | Полное окно «Движения склада», приход с складом/ячейкой, серийники |

Полное окно открывается только при **обоих** (`Utils.OpenArticleStockDialog`).

В репозитории **нет реализации** `IStockManagementModule` — только интерфейс `LogicPOS.Modules/StockManagement/IStockManagementModule.cs` и упрощённый `ProcessArticleStock`.

### 2.3. Что работает без плагина и без расширенной лицензии

Встроенный **`ProcessArticleStock`**:

- списание/возврат при продаже/отмене документа (`StockMode` у типа документа);
- корректировка остатка в карточке товара;
- простой приход `PosArticleStockDialog` (без склада);
- отчёт движений (`REPORT_LIST_STOCK_MOVEMENTS`).

Справочник **Склады** (Другие столы) — права + данные, не лицензия.

### 2.4. Что не включится «одной активацией»

Без плагина `IStockManagementModule`:

- `DialogArticleStock` (4 вкладки);
- `DialogAddArticleStock` с выбором склада (при сохранении вызывается `StockManagementModule.Add`);
- серийники, `fin_articlewarehouse` через UI модуля;
- расширенные отчёты по складу (нужна ещё лицензия).

### 2.5. Объём доработки модуля склада

| Уровень | Содержание | Ориентир |
|---------|------------|----------|
| **MVP** | Приход/расход + обновление `fin_articlewarehouse`, склад по умолчанию (`IsDefault`), списание при продаже, отмена документа | ~800–1200 строк, 1 сессия |
| **Средний** | Выбор склада в UI, синхронизация `article.Accounting` | +1–2 недели |
| **Полный** | Серийники, составные товары, смена серийника, вложения | 3–5 недель |

**Миграция БД для MVP склада не обязательна** — таблицы есть.

**Опционально (отдельно):** поля `Warehouse`/`Location` в `fin_articlestock` для аудита в журнале движений → правки схемы, XPO, views, отчётов.

### 2.6. UI — новые формы не нужны

Уже есть (~14 экранов): `DialogArticleStock`, `DialogAddArticleStock`, `DialogArticleWarehouse`, `TreeViewWarehouse`, и др. Не хватает **логики плагина**, который связывает формы с `fin_articlewarehouse`.

**Рекомендация для магазина вещей с одним штрихкодом на SKU:** склад **отложить**; при необходимости позже — MVP модуля со складом `IsDefault`, без серийников.

### 2.7. Регистрация плагина (на будущее)

- Вариант A: проект `LogicPOS.StockManagement.Plugin.dll` → папка `plugins`
- Вариант B (отладка): `ModulesSettings.StockManagementModule = new StockManagementModule()` в `Program.cs`

Интерфейс: `LogicPOS.Modules/StockManagement/IStockManagementModule.cs` — 4 перегрузки `Add(...)`.

---

## 3. Национальный каталог (НКТ) — анализ API

### 3.1. Роль НКТ vs CleverPos

| Система | Роль |
|---------|------|
| CleverPos | Товар, цена, скан, чек |
| НКТ | Заявка на карточку товара в гос. каталоге |

НКТ **не ищет товар при скане** на кассе. После публикации в НКТ `gtin` должен совпадать с `fin_article.BarCode`.

### 3.2. Текущее состояние в репозитории

- План в `TODO.md`, фаза **E**
- README упоминает `nationalCatalogApiKey`
- **Кода интеграции нет** (HTTP-клиент, UI, таблица связи)

### 3.3. API (официально)

- **Base URL:** `https://nationalcatalog.kz/gwp` (не голый `nationalcatalog.kz` — он отдаёт SPA HTML; не `stg.nct.kz`)
- **Auth:** заголовок `X-API-KEY`
- **Rate limit:** HTTP 429 — кэшировать справочники, не спамить status

### 3.4. Жизненный цикл заявки

```
POST   /portal/api/v1/products/requests              → id черновика
PUT    /portal/api/v1/products/requests/{id}         → атрибуты (полный список!)
PUT    /portal/api/v1/products/requests/{id}/moderation
GET    /portal/api/v1/products/requests/{id}/status  → опрос
PUT    /portal/api/v1/products/requests/{id}/publish
GET    /portal/api/v1/products/requests/attributes   → поля по oktru
GET    /portal/api/v1/dictionaries/...               → ОКТРУ, ТНВЭД, единицы
```

**Статусы:** `new`, `onModeration`, `accepted`, `underRevision`, `rejected`, `cancelled`, `readyToPublish`, `completed`, `existingProductSelected`.

**Условие включения в UI:** `ConfigurationSystemCountry.Code2 == "KZ"` **и** `nationalCatalogEnabled=true`.

### 3.5. Маппинг CleverPos → НКТ (MVP)

| CleverPos | НКТ attribute | Примечание |
|-----------|---------------|------------|
| `BarCode` | `gtin` | EAN-13, 13 цифр |
| `Designation` | `name_ru`, `short_name_ru` | |
| — | `name_kk` | обязателен в API — копия или отдельное поле |
| `Code` | `article` | внутренний артикул |
| — | `oktru` | **новое поле** — категория (picker) |
| — | `country` | `KZ` по умолчанию |
| `Price1` | — | в НКТ не передаётся |

Набор атрибутов **зависит от ОКТРУ** — для одежды разумно начать с фиксированного набора под 2–3 категории, не с универсального конструктора всех полей.

### 3.6. Предлагаемая архитектура

```
LogicPOS.NationalCatalog/           # новый проект
  NationalCatalogClient.cs
  Models/
  ArticleNationalCatalogMapper.cs

LogicPOS.UI/
  DialogArticle.cs                 # кнопки НКТ (только KZ)
  DialogNationalCatalogOktru.cs    # выбор ОКТРУ

fin_articlenationalcatalog         # предпочтительнее JSON в Notes
  Article, RequestId, Status, Oktru, Gtin, Xtин, LastError, UpdatedAt
```

**Новых больших форм не нужно** — расширение карточки товара + диалог ОКТРУ.

### 3.7. Оценка сроков (только товары)

| Этап | Срок |
|------|------|
| HTTP-клиент + конфиг + тест POST | 1–2 дня |
| Таблица связи + маппинг | 0.5 дня |
| UI статус / отправка в `DialogArticle` | 1–2 дня |
| Picker ОКТРУ | 2–3 дня |
| **MVP** (фикс. поля для одежды) | **~1–1.5 недели** |
| Полный динамический набор атрибутов | 3–4 недели |

### 3.8. Риски

- 422 валидация — разные поля по `oktru` → `GET .../attributes`
- `name_kk` обязателен
- GTIN уже в каталоге → `existingProductSelected`
- Утечка API-ключа → только локальный App.config, не git

### 3.9. Вне scope MVP НКТ

- Импорт всех товаров из НКТ в CleverPos (отдельная задача)
- Фискализация / ЭСФ / ККМ (фаза F)
- Печать этикеток (фаза C)

---

## 4. Порядок приоритетов (согласованный)

| # | Фаза | Содержание | Для магазина |
|---|------|------------|--------------|
| 1 | **B** | App.config, запуск KZ/ru-RU | обязательно |
| 2 | **C** | `BarCode`, этикетки EAN | обязательно |
| 3 | **D** | CleverApp + касса | обязательно |
| 4 | **E** | НКТ API | параллельная регистрация |
| 5 | **H** | Склад MVP (плагин) | **позже**, не блокер |
| 6 | **F** | ЭСФ/KKM/КГД | позже |

**Зависимость:** фаза **C** (штрихкоды) перед **E** (НКТ), т.к. `gtin` = `BarCode`.

---

## 5. Известные технические долги (из сессий разработки)

- `BarCodeTemplate_*.frx` печатает Code128/серийник, не EAN из `BarCode` — см. фазу C.
- Отчёты `ReportDocumentFinanceCustomerBalanceDetails.frx` и др.: опечатка `{0:#,##0.00'}` в `Format` — возможен падение `Prepare(true)` в FastReport.
- Retail seed: права на склады для владельца — правки в `Retail/ru/databasedata.sql` (если кнопка «Склады» неактивна).

---

## 6. Ссылки

| Ресурс | Путь |
|--------|------|
| Чеклист задач | [`TODO.md`](../TODO.md) |
| README KZ | [`README.md`](../README.md) |
| SQL страны KZ | `LogicPOS.UI/Resources/Database/Other/Country/KZ/` |
| Seed ru | `LogicPOS.UI/Resources/Database/Data/{Theme}/ru/databasedata.sql` |
| Интерфейс склада | `LogicPOS.Modules/StockManagement/IStockManagementModule.cs` |
| Views склада | `LogicPOS.UI/Resources/Database/databaseviews.sql` |

---

*Документ обновлять при изменении решений. Реализацию вести по чеклисту в `TODO.md`.*
