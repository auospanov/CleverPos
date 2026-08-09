# CleverPos License API

.NET 8 Web API + админка. База MySQL `cleverpos`. Подпись файлов — через общий модуль **CleverPos.License.Core** (тот же, что LicenseGenerator).

<<<<<<< HEAD
## Поток

1. Касса офлайн проверяет подпись и `ValidUntilUtc` в `licence.lic`.
2. Если срок истёк / нет подписи → `POST /api/licenses/renew`.
3. Сервер: оплата месяца + привязка ПК → выдаёт новый подписанный файл.
4. Касса перезаписывает `licence.lic` и работает дальше без сети до следующего `ValidUntil`.
=======
Таблицы: `licenses`, `license_activations`, `license_payments`, `license_access_logs`.

## Правила

1. Если ключа ещё нет в админке, первый запрос кассы **создаёт** лицензию (право первой ночи), отмечает текущий месяц оплаченным и сажает идентификатор компьютера.
2. Запрос с **другого** компьютера — отказ. В админке нажмите **«Разрешить другой ПК»** (по звонку клиента) — старый ПК отвяжется, новый при старте кассы привяжется сам.
3. Следующие месяцы нужна оплата в `license_payments`. Нет оплаты за текущий месяц — касса не запускается.
4. Отключённую в админке лицензию касса не поднимет.
5. Каждый `validate` пишется в **Журнал входов** (`/admin/access-log`): ключ, компьютер, IP, разрешено/отказ.
>>>>>>> 51c4e42556c3063557d3d40d426316d29c69bacf

## Запуск

```bash
cd CleverPos.License.Api
dotnet run --launch-profile http
```

<<<<<<< HEAD
Docker (контекст — корень репо, чтобы подтянуть Core):
=======
- Админка: http://localhost:5088/admin  
- Журнал: http://localhost:5088/admin/access-log  
- Ключ входа (Development): `dev-admin-key` (`AdminApiKey` в appsettings)  
- Swagger: http://localhost:5088/swagger  

Или Docker (только API):
>>>>>>> 51c4e42556c3063557d3d40d426316d29c69bacf

```bash
cd CleverPos.License.Api
copy .env.example .env
docker compose up --build
```

Админка: http://localhost:5088/admin (`dev-admin-key` в Development)

<<<<<<< HEAD
Приватный ключ: `LicenseSigning:PrivateKeyXml` в appsettings (пусто = ключ по умолчанию из Core). В проде задайте свой ключ.
=======
- список лицензий, компьютер, статус оплаты месяца;
- создать лицензию;
- **Разрешить другой ПК** — отвязать старый компьютер (перенос по звонку);
- журнал всех входов / отказов;
- отметить оплату за месяц / любой период;
- включить / выключить лицензию.

В `LogicPOS.UI/App.config`:

- `licenseApiEnvironment` = `local` (сейчас) или `production` (когда сервис будет в интернете)
- `licenseApiLocalUrl` = `http://localhost:5088`
- `licenseApiProductionUrl` = публичный URL API

Ключ онлайн-проверки **не** задаётся в `App.config`. Касса читает `licence.lic` и отправляет расшифрованный `HardwareId` как `licenseKey`. В админке создавайте лицензию с тем же ключом (HardwareId из генератора / `licence.lic`) и отметьте оплату текущего месяца.

`POST /api/licenses/validate` всегда отвечает `200` и `{ "allowed": true|false, "message": "..." }`. Отказ лицензии — это `allowed: false`, не HTTP 403.
>>>>>>> 51c4e42556c3063557d3d40d426316d29c69bacf
