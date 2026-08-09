# CleverPos License API

.NET 8 Web API + админка. База MySQL `cleverpos`. Подпись файлов — через общий модуль **CleverPos.License.Core** (тот же, что LicenseGenerator).

## Поток

1. Касса офлайн проверяет подпись и `ValidUntilUtc` в `licence.lic`.
2. Если срок истёк / нет подписи → `POST /api/licenses/renew`.
3. Сервер: оплата месяца + привязка ПК → выдаёт новый подписанный файл.
4. Касса перезаписывает `licence.lic` и работает дальше без сети до следующего `ValidUntil`.

## Запуск

```bash
cd CleverPos.License.Api
dotnet run --launch-profile http
```

Docker (контекст — корень репо, чтобы подтянуть Core):

```bash
cd CleverPos.License.Api
copy .env.example .env
docker compose up --build
```

Админка: http://localhost:5088/admin (`dev-admin-key` в Development)

Приватный ключ: `LicenseSigning:PrivateKeyXml` в appsettings (пусто = ключ по умолчанию из Core). В проде задайте свой ключ.
