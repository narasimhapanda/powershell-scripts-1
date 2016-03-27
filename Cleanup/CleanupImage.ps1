.\Set-FontSubstitutes.ps1
Set-FontSubstitutes
.\Remove-DefaultAppxApps.ps1
$Result = Remove-DefaultAppxApps -Confirm:$False
If ( $Result ) { Write-Host "Reboot required." }
.\Set-CleanMgrSettings.ps1
Start-Process -FilePath $env:SystemRoot\system32\Cleanmgr.exe -ArgumentList "/sagerun:100"