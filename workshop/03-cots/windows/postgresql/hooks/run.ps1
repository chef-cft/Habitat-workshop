Start-Service {{cfg.service_name}}
Write-Host "{{pkg.name}} is running"

try {
    while($(Get-Service {{cfg.service_name}}).Status -eq "Running") {
        Start-Sleep -Seconds 1
    }
}
finally {
    $currentStatus = (Get-Service {{cfg.service_name}}).Status
    if($currentStatus -eq "Running") {
        Write-Host "{{pkg.name}} stopping..."
        Stop-Service {{cfg.service_name}}
        $currentStatus = (Get-Service {{cfg.service_name}}).Status
    }
    if($currentStatus -eq "StopPending") {
        Write-Host "Waiting for {{pkg.name}} to stop..."
        while($currentStatus -eq "StopPending") {
            Start-Sleep -Seconds 5
            $currentStatus = (Get-Service {{cfg.service_name}}).Status
        }
    }
    Write-Host "{{pkg.name}} has stopped"
}
