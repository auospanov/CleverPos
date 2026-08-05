# CleverPos License API

.NET 8 Web API. Работает с **существующей** MySQL `cleverpos` на `92.38.49.47`. Новую БД не поднимает — только создаёт таблицы `licenses` и `license_activations` миграциями.

## Запуск локально

API на вашей машине, база — удалённая:

```bash
cd CleverPos.License.Api
dotnet run --launch-profile http
```

Или в Docker (только контейнер API, без MySQL):

```bash
cd CleverPos.License.Api
copy .env.example .env
docker compose up --build
```

- API: http://localhost:5088/swagger  
- Health: http://localhost:5088/health  

При старте применяются EF-миграции в базу `cleverpos`.

## Создать лицензию (админ)

```bash
curl -X POST http://localhost:5088/api/admin/licenses ^
  -H "Content-Type: application/json" ^
  -H "X-Admin-Key: dev-admin-key" ^
  -d "{\"companyName\":\"Test Shop\",\"maxActivations\":1}"
```

Ключ пропишите в `LogicPOS.UI/App.config` (`licenseKey`).

## Проверка с кассы

```http
POST /api/licenses/validate
{
  "licenseKey": "...",
  "computerId": "...",
  "machineName": "CASH-01"
}
```

- пара уже есть → разрешить;
- лицензия есть, слот свободен → посадить компьютер и разрешить;
- иначе → 403.

## Публикация

Повесьте API за nginx/Caddy на домен, `ASPNETCORE_ENVIRONMENT=Production`, смените `AdminApiKey`. Строка подключения та же — база `cleverpos`.
