# requires -version 5
# Requires WMF 5.0 to download modules from the PowerShell Gallery

# Aaron Parker, Atlantis Computing, March 2016
# v1.0 initial version
# v1.1 updated to not require elevation to install modules, by install/load to/from local user context/folder locations
# v1.2 updated comments. Changed Remove-SSHSession to remove only current session instead of all sessions. Enabled $Controllers to accept value from the pipeline

Function Get-IlioRamstats {
    <#
        .SYNOPSIS
            Gets the output from ramstats.py from one or more ILIO controllers.
 
        .DESCRIPTION
            This function can be used to get the output from ramstats from one or more ILIO controllers and output the result to Excel.
 
        .PARAMETER Controllers
            Specifies the address (IP or host name) of single ILIO controller or multiple controllers. Seperate a list with commas or accepts value from the pipeline.

        .PARAMETER Username
            Specifies the username used to connect to the ILIO controller/s.
 
        .PARAMETER Password
            Specifies the password used when connecting to the ILIO controller/s.

        .PARAMETER OutputToExcel
            Specifies whether to store the captured information into an Excel workbook. Requires Excel to be installed locally.
 
        .PARAMETER Path
            Specifies the path to the Excel workbook to output.
  
        .EXAMPLE
            Get-IlioRamstats -Controllers "192.168.100.1", "192.168.0.2", "192.168.0.3" -OutputToExcel -Path C:\Temp\ControllersRamStats.xlsx"
 
        .EXAMPLE
            Get-IlioRamstats -Controllers "192.168.100.1", "192.168.0.2", "192.168.0.3" | Export-Csv -NoTypeInformation -Path C:\Temp\ControllersRamStats.csv"

        .NOTES
 
        .LINK
            http://atlantiscomputing.com
    #>
    param(
        [Parameter(Mandatory=$true, Position=0, HelpMessage="Specify an ILIO controller or list of controllers.")]
        [array]$Controllers,
 
        [Parameter(Mandatory=$false, HelpMessage="Specify the username used to connect to the ILIO controller/s.")]
        [string][ValidateNotNullOrEmpty()]$Username = "poweruser",

        [Parameter(Mandatory=$false, HelpMessage="Specify the password used to connect to the ILIO controller/s")]
        [string][ValidateNotNullOrEmpty()]$Password = "poweruser",

        [Parameter(Mandatory=$false, HelpMessage="Output the data returned from ramstats.py into an Excel workbook.")]
        [switch]$OutputToExcel = $false,
 
        [Parameter(Mandatory=$false, HelpMessage="Specify the path to the Excel workbook.")]
        [string]$Path
     )

    # Import SSH and Excel modules
    # Set the PowerShell gallery as a trusted resource. Requires Windows 10 or WMF 5.0 and Elevated rights
    # https://www.powershellgallery.com
    
    # Check that PowerShell Gallery is a trusted repository
    If (Get-PSRepository -Name PSGallery | Where-Object { $_.InstallationPolicy -eq "Untrusted" }) {
        Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
    }

    # Install the Posh-SSH module
    If (-Not (Get-Module -ListAvailable -Name Posh-SSH)) {
        Install-Module -Name Posh-SSH -Scope CurrentUser
    }

    # Install the ImportExcel module
    If (-Not (Get-Module -ListAvailable -Name ImportExcel)) {
        Install-Module -Name ImportExcel -Scope CurrentUser
    }

    # If modules are not loaded, load them
    If (-Not (Get-Module -Name Posh-SSH)) {
        Import-Module -Name "$Home\Documents\WindowsPowerShell\Modules\Posh-SSH"
    }

    If (-Not (Get-Module -Name ImportExcel)) {
        Import-Module -Name "$Home\Documents\WindowsPowerShell\Modules\ImportExcel"
    }

    # Output array
    If (Test-Path variable:AllStats) { Remove-Variable AllStats }
    $AllStats = @()

    # Create credential to pass to SSH session
    # Need to convert plain text password into a secure string
    $SPassword = convertto-securestring -String $Password -AsPlainText -Force
    $cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $Username, $SPassword

    ForEach ( $controller in $Controllers ) {
    
        # Open SSH session to the controller, pass credential and accept any SSH key presented
        If (Test-Path variable:session) { Remove-Variable session }
        $session = New-SshSession -ComputerName $controller -Credential $cred -AcceptKey

        # Grab the raw output from ramstats.py and remove seperator lines
        If (Test-Path variable:session) {
            $rawoutput = Invoke-SSHCommand -SessionId $session.Sessionid -Command '/opt/ramstats/ramstats.py -p'
            [System.Collections.ArrayList]$array = $rawoutput.output -split "\n+"
            [Array]$items = $array.Split("=") -ne "----------------------------"

            # Break ramstat.py output into an object. Relies on consistent output from ramstats.py
            # Put specific values into a table, removing characters that are not numbers
            $pattern = '[^0-9.]'
            $obj = New-Object psobject -Property @{
                Controller = $controller
                VMProvisionedSize = $items[1] -replace $pattern, ''
                InUseSize = $items[3] -replace $pattern, ''
                FreeSize = $items[5] -replace $pattern, ''
                MemorySize = $items[7] -replace $pattern, ''
                FreeMemSize = $items[9] -replace $pattern, ''
                DedupePercent = $items[11] -replace $pattern, ''
                CompressPercent = $items[13] -replace $pattern, ''
                OverallOptimizePercent = $items[15] -replace $pattern, ''
                VMFreeSpace = $items[17] -replace $pattern, ''
            }

            # Add object to the output array to create a table of outputs
            $AllStats += $obj

            # Remove SSH session to current ILIO controller
            Remove-SSHSession -SessionId $session.Sessionid > $Null
        }

    }

    # Export stats to Excel if specified on command
    If ($OutputToExcel) {

        $AllStats | Export-Excel -Path $Path
        Write-Host "Output Excel workbook to $Path."
    }
    
    # Return the table of output values
    Return $AllStats
}