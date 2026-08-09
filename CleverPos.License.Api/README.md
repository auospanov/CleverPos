# CleverPos License API

.NET 8 Web API + админка. База MySQL `cleverpos`. Подпись файлов — через общий модуль **CleverPos.License.Core** (тот же, что LicenseGenerator).

Таблицы: `licenses`, `license_activations`, `license_payments`, `license_access_logs`.

## Поток

1. Касса офлайн проверяет подпись и `ValidUntilUtc` в `licence.lic`.
2. Если срок истёк / нет подписи → `POST /api/licenses/renew`.
3. Сервер: оплата месяца + привязка ПК → выдаёт новый подписанный файл; пишет запись в журнал.
4. Касса перезаписывает `licence.lic` и работает дальше без сети до следующего `ValidUntil`.
5. Другой ПК — отказ, пока в админке не нажмёте «Разрешить другой ПК» / очистку.

## Запуск

```bash
cd CleverPos.License.Api
dotnet run --launch-profile http
```

- Админка: http://localhost:5088/admin  
- Журнал: http://localhost:5088/admin/access-log  
- Ключ входа (Development): `dev-admin-key`  
- Swagger: http://localhost:5088/swagger  

Docker (контекст — корень репо, чтобы подтянуть Core):

```bash
cd CleverPos.License.Api
copy .env.example .env
docker compose up --build
```

Приватный ключ: `LicenseSigning:PrivateKeyXml` в appsettings (пусто = ключ по умолчанию из Core).
