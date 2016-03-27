Function Get-CleanmgrSettings {
    <#
        .SYNOPSIS
            Gets Disk Clean Up tool settings from registry and returns commands to write those settings to the Registry.
 
        .DESCRIPTION
            Gets the administrator to manually set Disk Clean Up tool settings and then
            retrieves settings from the Registry. Returns required PowerShell commands to
            add settings to the Registry on a different Windows instance.

        .PARAMETER Path
            Specify a path to Cleanmgr.exe if it does not exist in the default location.
            Useful for Windows Server where a  copy of Cleanmgr.exe is under the WinSxs folder.
  
        .EXAMPLE
            Get-CleanmgrSettings | Out-File Set-CleanmgrSettings.ps1
 
        .NOTES
 	        NAME: Get-CleanmgrSettings.ps1
	        VERSION: 1.0
	        AUTHOR: Aaron Parker
	        LASTEDIT: March 14, 2016
 
        .LINK
            http://stealthpuppy.com
    #>
    [CmdletBinding(SupportsShouldProcess = $False, ConfirmImpact = "None", DefaultParameterSetName = "Path")]
    PARAM (
        [Parameter(Mandatory=$false, Position=0, HelpMessage="Specify path to Cleanmgr.exe if it does not exist in the default location.")]
        [string]$Path = "$env:SystemRoot\SYSTEM32\Cleanmgr.exe"
    )

    BEGIN {
        Write-Verbose "Getting Disk Cleanup tool settings."
        
        # Set options
        Set-StrictMode -Version 2
        # $ErrorActionPreference = 'SilentlyContinue'
        
        [string]$sageset = "/sageset:100"
        
        # Create array to hold registry update commands
        $Array = @()
    }

    PROCESS {
        # Check whether script is elevated - Cleanmgr needs to be elevated to show system settings
        If (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {

            # Start CleanMgr elevated and wait for user to configure. 100 is the configuration we're going to set
            Start-Process $Path -ArgumentList $sageset -Verb RunAs -Wait
        } Else {

            # Start CleanMgr and wait for user to configure. 100 is the configuration we're going to set
            Start-Process $Path -ArgumentList $sageset -Wait
        }

        # Get the CleanMgr configuration key from the registry
        $keys = Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches | Where-Object { $_.PSIsContainer -eq $True }

        # Find sub-keys that have a StateFlags0100 value in them
        ForEach ( $key in $keys ) {
            
            # Get all values from the sub-key
            $values = Get-ItemProperty $key.PSPath
            
            # If StateFlags0100 exists, write out command to add key, value and data to the registry
            If ( [bool]($values.PSObject.Properties.Name -match "StateFlags0100") ) {
                $rpath = $values.PSPath
                $Array += "New-ItemProperty -Path '$rpath' -Name StateFlags0100 -Value 2 -Force"
            }
        }    
    }
    
    END {

        # Return array of PowerShell commands for writing to a new Registry 
        Return $Array        
    }
}