Function Get-AppxPackageFromStart {
<#
        .SYNOPSIS
            Returns the AppX package that correlates to the application display name on the Start menu.
 
        .DESCRIPTION
            Returns the AppX package object that correlates to the application display name on the Start menu.
            Returns null if the name specified is not found or the shortcut points to a non-AppX app.

        .PARAMETER Name
            Specify a shortcut display name to return the AppX package for.
  
        .EXAMPLE
            PS C:\> Get-AppxPackageFromStart -Name "Twitter"
            
            Returns the AppX package for the shortcut 'Twitter'.
             
        .NOTES
 	        NAME: Get-AppxPackageFromStart.ps1
	        VERSION: 1.0
	        AUTHOR: Aaron Parker
	        LASTEDIT: March 15, 2016
 
        .LINK
            http://stealthpuppy.com
    #>
    [CmdletBinding(SupportsShouldProcess = $False, ConfirmImpact = "None", DefaultParameterSetName = "Name")]
    PARAM (
        [Parameter(Mandatory=$true, Position=1, HelpMessage="Specify a Start menu shortcut name.")]
        [string[]]$Name
    )
    
    BEGIN {
        
        #Return an object for the selected shortcut name
        $StartPkg = Get-StartApps -Name $Name        
    }
    
    PROCESS {
        
        If ( -not ($StartPkg -eq $Null )) {
        
            # Return an AppX package object by comparing the Start menu package AppId to the PackageFamilyName up to the ! character     
            $Package = Get-AppxPackage | Where-Object { ($StartPkg.AppId -split "!")[0] -contains $_.PackageFamilyName }        
        } Else {
            
            # Package was not found (which should only happen if shortcut is not an AppX app or wrong shortcut specified)
            $Package = $False
        }
    }

    END {
        
        Return $Package   
    }
}