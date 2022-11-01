if (!(Get-Service {{cfg.service_name}} -ErrorAction SilentlyContinue)) {
    Write-Host "Installing postgres..."
    Start-Process postgresql.exe -ArgumentList "--unattendedmodeui none --mode unattended --superpassword {{cfg.password}} --servicename {{cfg.service_name}} --servicepassword {{cfg.password}}" -wait -NoNewWindow
}
Write-Host "Installation complete!"

Stop-Service {{cfg.service_name}}

$currentStatus = (Get-Service {{cfg.service_name}}).Status
if($currentStatus -eq "StopPending") {
    while($currentStatus -eq "StopPending") {
        Start-Sleep -Seconds 1
        $currentStatus = (Get-Service {{cfg.service_name}}).Status
    }
}
