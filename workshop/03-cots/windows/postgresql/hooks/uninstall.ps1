$version = "{{pkg.version}}"
$version -match "^([^.]+)"
$major = $Matches[0]
Start-Process "$env:ProgramFiles\PostgreSQL\$major\uninstall-postgresql.exe" -ArgumentList "--mode unattended" -Wait -NoNewWindow
Write-Host "Removing Data Directory"
Remove-Item "$env:ProgramFiles\PostgreSQL" -Recurse -Force
