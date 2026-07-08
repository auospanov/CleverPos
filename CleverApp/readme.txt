  dotnet publish -f net9.0-android -c Release /p:AndroidPackageFormat=apk /p:AndroidKeyStore=false

Конфиг: Resources/Raw/appsettings.json

  ApiEnvironment:
    "Test"       → https://apitest.kmlife.kz
    "Production" → https://api.kmlife.kz

  ApiBaseUrlOverride:
    если задан — подменяет URL (например http://192.168.0.106:5000 для LAN без VPN)

  EnableShopMode:
    true  — режим магазина (LogicPOS: поиск сервера, штрихкоды по LAN)
    false — журнал посетителей (логин → сканирование удостоверения → API)
