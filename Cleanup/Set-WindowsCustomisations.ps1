<#
    .SYNOPSIS
    Configuration changes to a default install of Windows.
  
    .NOTES
    NAME: Set-WindowsCustomisations.ps1
    VERSION: 1.0
    AUTHOR: Aaron Parker
    LASTEDIT: April 24, 2016
 
    .LINK
    http://stealthpuppy.com
#>

# Enable the Remote Desktop firewall group
Enable-NetFirewallRule -DisplayGroup "Remote Desktop" -Verbose

# Remove sample files if they exist
$Paths = "$env:PUBLIC\Music\Sample Music", "$env:PUBLIC\Pictures\Sample Pictures", "$env:PUBLIC\Videos\Sample Videos", "$env:PUBLIC\Recorded TV\Sample Media"
ForEach ( $Path in $Paths ) {
    Write-Host "$Path exists."
    If ( Test-Path $Path ) { Remove-Item $Path -Recurse -Force }
}

# Set FontSubstitutes
. .\Set-FontSubstitutes.ps1
Set-FontSubstitutes

# If Windows 10, remove in-box Universal Apps 
If ([Environment]::OSVersion.Version -ge (New-Object 'Version' 10,0)) {
    . .\Remove-DefaultAppxApps.ps1
    $Result = Remove-DefaultAppxApps -Confirm:$False
    If ( $Result ) { Write-Host "Reboot required." }    
}

# Run Disk Cleanup tool
. .\Set-CleanMgrSettings.ps1
Start-Process -FilePath $env:SystemRoot\system32\Cleanmgr.exe -ArgumentList "/sagerun:100"