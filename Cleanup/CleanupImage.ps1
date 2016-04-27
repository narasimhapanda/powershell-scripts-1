<#
    .SYNOPSIS
    Sets Disk Cleanup tool settings for each operatng system.
  
    .NOTES
    NAME: Set-CleanMgrSettings.ps1
    VERSION: 1.1
    AUTHOR: Aaron Parker
    LASTEDIT: April 27, 2016
 
    .LINK
    http://stealthpuppy.com
#>

# Set FontSubstitutes
. .\Set-FontSubstitutes.ps1
Set-FontSubstitutes

# Remove default Universal apps
. .\Remove-DefaultAppxApps.ps1
$Result = Remove-DefaultAppxApps -Confirm:$False
If ( $Result ) { Write-Host "Reboot required." }

# Run the Disk Cleanup tool 
. .\Set-CleanMgrSettings.ps1
Start-Process -FilePath $env:SystemRoot\system32\Cleanmgr.exe -ArgumentList "/sagerun:100" -Wait