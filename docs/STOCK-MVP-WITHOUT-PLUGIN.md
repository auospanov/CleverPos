# Склад MVP без плагина (CleverPos)

**Дата:** 2026-08-12  
**Статус:** в работе — без `IStockManagementModule`, без серийников  
**Кабинет:** `https://dominium.kz` · API: `https://api.dominium.kz`

Связанные документы: [`KZ-RETAIL-WAREHOUSE-NKT-ANALYSIS.md`](KZ-RETAIL-WAREHOUSE-NKT-ANALYSIS.md), [`koncepciya_magazin_avtomatizaciya.md`](../koncepciya_magazin_avtomatizaciya.md) § склад / модель B.

---

## Цель

Вести остатки в рознице **без DLL-плагина склада**:

- один склад на кассу (`IsDefault`);
- приход / продажа / возврат / ручная корректировка;
- `fin_article.Accounting` синхронизирован с `fin_articlewarehouse.Quantity`;
- облако получает `stock_balance` (уже есть outbox).

**Не входит в MVP:** серийники, ячейки (кроме одной «Общая»), перемещения между складами, WMS, минимальный остаток.

Серийники — **не нужны** для сценария «один EAN = много штук». Возможность оставить под вопросом на потом; в коде MVP их не используем.

---

## Две модели остатка (уже в БД)

| Таблица | Роль |
|--------|------|
| `fin_articlestock` | Журнал движений (+/−) |
| `fin_article.Accounting` | Быстрый остаток на карточке |
| `fin_articlewarehouse` | Остаток товар × склад × локация |

До MVP склад писался только в журнал + `Accounting`. `fin_articlewarehouse` почти не заполнялся без плагина.

---

## Что уже работало без плагина

- Приход через `PosArticleStockDialog` → `ProcessArticleStock.In`
- Списание при продаже / отмене (`DocumentType.StockMode`)
- Класс «Товары» с `WorkInStock = 1`
- Cloud outbox `stock_balance` / `sale_committed`
- UI-формы склада (~14 экранов) — но вход был завязан на плагин

## Что блокировало

1. `OpenArticleStockDialog` открывал полное окно только при `StockManagementModule != null`
2. `GenericCRUDWidgetList` при приходе из `DialogAddArticleStock` вызывал `StockManagementModule.Add` (NRE без плагина)
3. `ProcessArticleStock` не обновлял `fin_articlewarehouse`
4. В `Data/**/ru` не было сида `fin_warehouse` / `fin_warehouselocation` (в pt есть)

---

## План реализации (пошагово)

| # | Шаг | Статус |
|---|-----|--------|
| 1 | Документ (этот файл) | done |
| 2 | Сид «Основной» склад + локация «Общая» (ru) + runtime ensure | done |
| 3 | `ProcessArticleStock` → upsert `fin_articlewarehouse` (без серийников) | done |
| 4 | Разблокировать UI: `DialogArticleStock` + приход без плагина | done |
| 5 | Кредитка/NC → StockMode In (возврат на склад) | done |
| 6 | Политика нулевого остатка на кассе | done (только при CHECK_STOCKS=True) |
| 7 | Простая инвентаризация | done (кнопка в окне склада) |
| 8 | Смоук + кабинет `dominium.kz` | next |

## Безопасность «без склада»

- Блокировка продаж по остатку — **только** если preference `CHECK_STOCKS=True`. Иначе касса как раньше.
- `fin_articlewarehouse` обновляется **только если** склад уже есть; иначе движение пишется в журнал + Accounting, warehouse пропускается.
- Склад по умолчанию **создаётся** только при инвентаризации / явном сиде, не на каждой продаже.
- Инвентаризация — только из BackOffice → Движения склада → «Инвентаризация».

**Плагин `IStockManagementModule` не делаем** — логика в `ProcessArticleStock`.

---

## Ключевые файлы

| Файл | Изменение |
|------|-----------|
| `LogicPOS.Modules/StockManagement/ProcessArticleStock.cs` | upsert warehouse (optional), inventory adjust |
| `LogicPOS.UI/.../PosInventoryAdjustDialog.cs` | UI инвентаризации |
| `LogicPOS.UI/.../DialogArticleStock.cs` | кнопка «Инвентаризация» |
| `LogicPOS.UI/Classes/Utils/Utils.cs` | `OpenArticleStockDialog`, `CHECK_STOCKS` |
| `LogicPOS.UI/.../GenericCRUDWidgetList.cs` | `ProcessArticleStock` вместо плагина |
| `LogicPOS.UI/Resources/Database/Data/**/ru/databasedata.sql` | INSERT склада |
| `LogicPOS.Finance/.../DocumentProcessingUtils.cs` | уже fallback на `ProcessArticleStock` |

---

## Как пользоваться после MVP

1. BackOffice → **Движения склада** — полное окно  
2. Вкладка движений → Insert → приход (товар + qty; склад по умолчанию)  
3. Вкладка товаров → **Инвентаризация** (факт vs учёт → In/Out)  
4. Продажа FS списывает Accounting + warehouse (если склад есть)  
5. `cloudStoreId` в App.config → кабинет видит остаток  

Один магазин = один `cloudStoreId` = один дефолтный склад на этой кассе.  
Магазин **без склада**: не включайте `CHECK_STOCKS`, не открывайте инвентаризацию — продажи идут как раньше.

---

## Тест-чеклист

1. [ ] В БД есть склад `IsDefault=1` и локация  
2. [ ] Приход 10 шт → `Accounting=10`, строка в `fin_articlewarehouse`  
3. [ ] Продажа 3 → оба остатка = 7  
4. [ ] Кредитка/NC возвращает остаток  
5. [ ] Продажа при qty=0 блокируется **только** если `CHECK_STOCKS=True` и `stockAllowNegative=false`  
6. [ ] Без `CHECK_STOCKS` продажа при qty=0 **не** блокируется  
7. [ ] Инвентаризация: факт ≠ учёт → движение INV  
8. [ ] Outbox → `/api/cloud/sync` → кабинет  
9. [ ] Без `plugins/*Stock*` DLL всё открывается  

---

## Отложено (под вопросом)

- Серийники / этикетки по SN  
- Несколько складов и перемещения  
- Поля Warehouse в журнале `fin_articlestock`  
- Полный `IStockManagementModule` DLL  
