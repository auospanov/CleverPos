# CleverPos License API

.NET 8 Web API + админка. База — существующая MySQL `cleverpos` на `92.38.49.47`.

Таблицы: `licenses`, `license_activations`, `license_payments`.

## Правила

1. Первый запрос кассы с ключом **сажает** идентификатор компьютера.
2. Запрос с **другого** компьютера — отказ, пока в админке не нажмёте «Очистить ПК».
3. Каждый месяц нужна оплата в `license_payments`. Нет оплаты за текущий месяц — касса не запускается.

## Запуск

```bash
cd CleverPos.License.Api
dotnet run --launch-profile http
```

- Админка: http://localhost:5088/admin  
- Ключ входа (Development): `dev-admin-key` (`AdminApiKey` в appsettings)  
- Swagger: http://localhost:5088/swagger  

Или Docker (только API):

```bash
docker compose up --build
```

## Админка

- список лицензий, компьютер, статус оплаты месяца;
- создать лицензию;
- очистить идентификатор компьютера (смена ПК);
- отметить оплату за месяц / любой период;
- включить / выключить лицензию.

В `LogicPOS.UI/App.config`:

- `licenseApiEnvironment` = `local` (сейчас) или `production` (когда сервис будет в интернете)
- `licenseApiLocalUrl` = `http://localhost:5088`
- `licenseApiProductionUrl` = публичный URL API

Ключ онлайн-проверки **не** задаётся в `App.config`. Касса читает `licence.lic` и отправляет расшифрованный `HardwareId` как `licenseKey`. В админке создавайте лицензию с тем же ключом (HardwareId из генератора / `licence.lic`) и отметьте оплату текущего месяца.

`POST /api/licenses/validate` всегда отвечает `200` и `{ "allowed": true|false, "message": "..." }`. Отказ лицензии — это `allowed: false`, не HTTP 403.
