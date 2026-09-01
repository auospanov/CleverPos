  # Debug / Release — оба подписываются signing/cleverapp.jks (см. signing/README.md)
  dotnet build -f net9.0-android -c Debug
  dotnet publish -f net9.0-android -c Release /p:AndroidPackageFormat=apk

Конфиг: Resources/Raw/appsettings.json

  ApiEnvironment:
    "Test"       → https://apitest.kmlife.kz
    "Production" → https://api.kmlife.kz

  ApiBaseUrlOverride:
    если задан — подменяет URL (например http://192.168.0.106:5000 для LAN без VPN)

  EnableShopMode:
    true  — режим магазина (LogicPOS: поиск сервера, штрихкоды по LAN)
37:77:42:C9:8B:28:66:F3:2D:62:2E:E4:B3:7A:CA:E9:AE:2E:C5:14:F3:D5:95:BE:BB:CA:9B:44:68:35:83:A9

Файл
CleverApp/signing/cleverapp.jks
Alias
cleverapp
Пароль (store + key)
IPofdQpeFiS94LT7kRUsrEu1