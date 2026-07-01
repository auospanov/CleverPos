# Каталог `shop/`

## Название в чеке = только тип

**Designation** и **SubFamily** совпадают: `Блуза`, `Топ`, `Брюки` — без цвета, бренда и прочего.

Цвет/модель для себя — колонка **PhotoNote** в `articles_import.csv` и имя файла в `images/` (в CleverPos не импортируется).

## Смена цвета завтра

| Ситуация | Действие |
|----------|----------|
| Тот же тип и **та же цена** | Оставить Code и BarCode, при желании заменить фото |
| **Другая цена** (другой tier) | Новая строка: новый Code + BarCode, Designation снова просто «Блуза» |
| Несколько блуз по одной цене | Несколько Code (BL-001…), в чеке везде «Блуза», различие — скан |

## Импорт

`articles_import_backoffice.csv` → Excel → BackOffice.

Цены — **максимум** коридора (колонка «до») из `price_tiers.txt`. Подробнее: `PRICING-ANALYSIS.md`.

## Демо при первом запуске CleverPos

В `LogicPOS.UI/App.config`:

```xml
<add key="useDatabaseDataDemo" value="true" />
<add key="useShopCatalogDemo" value="true" />
```

| useShopCatalogDemo | Демо-товары при создании БД |
|--------------------|-----------------------------|
| `true` | 18 SKU из `shop/` (скрипт `Resources/Database/Demos/Shop/databasedatademo_shop.sql`) |
| `false` | как обычно по `appOperationModeToken` (напр. ClothingStore) |

Остальные данные БД (настройки, пользователи, KZ) — без изменений. Меняются только семейства / подсемейства / товары.

После смены флага нужна **новая** база: удалите `logicposdb.db` и запустите приложение снова.
