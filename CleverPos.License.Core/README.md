# CleverPos.License.Core

Общий модуль подписи / проверки / выдачи `licence.lic`.

Используется:

- **LicenseGenerator** (WinForms) — ручная выдача файла
- **CleverPos.License.Api** — renew на сервере после оплаты
- **LogicPOS.UI** — офлайн-проверка подписи и срока

## Формат

INI `[Licence]` + 3DES поля + RSA-SHA256 `Signature` по канонической строке:

```
v1
LicenseKey=...
HardwareId=...
Company=...
ValidUntilUtc=...
IssuedAtUtc=...
```

Приватный ключ — только на сервере / в генераторе. В кассе — публичный ключ.
