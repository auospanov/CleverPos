# Открыть входящие TCP 5000 и UDP 8888 для LogicPOS (локальная сеть).
# Запуск от имени администратора.

$ErrorActionPreference = "Stop"

$rules = @(
    @{ Name = "LogicPOS Barcode HTTP"; Port = 5000; Protocol = "TCP" },
    @{ Name = "LogicPOS Barcode Discovery"; Port = 8888; Protocol = "UDP" }
)

foreach ($r in $rules) {
    $existing = Get-NetFirewallRule -DisplayName $r.Name -ErrorAction SilentlyContinue
    if ($existing) {
        Write-Host "Rule already exists: $($r.Name)"
        continue
    }
    New-NetFirewallRule -DisplayName $r.Name `
        -Direction Inbound `
        -Action Allow `
        -Protocol $r.Protocol `
        -LocalPort $r.Port `
        -Profile Private,Domain `
        | Out-Null
    Write-Host "Created: $($r.Name) ($($r.Protocol) $($r.Port))"
}

Write-Host "Done. Restart LogicPOS and try sending from phone."
