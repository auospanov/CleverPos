# Android signing (CleverApp)

- **Keystore:** `cleverapp.jks`
- **Alias:** `cleverapp`
- **Passwords:** in `signing.props` (gitignored)

Debug and Release both sign with this key when `signing.props` exists.

## SHA-256 fingerprint

```
37:77:42:C9:8B:28:66:F3:2D:62:2E:E4:B3:7A:CA:E9:AE:2E:C5:14:F3:D5:95:BE:BB:CA:9B:44:68:35:83:A9
```

Compact (no colons):

```
377742c98b2866f32d622ee4b37acae9ae2ec514f3d595bebbca9b44683583a9
```

## Verify from APK

```powershell
& "$env:LOCALAPPDATA\Android\Sdk\build-tools\35.0.0\apksigner.bat" verify --print-certs path\to\app.apk
```

## Backup

Keep a copy of `cleverapp.jks` and the passwords offline. Losing them means you cannot update the same Play Store / device-signed app.
