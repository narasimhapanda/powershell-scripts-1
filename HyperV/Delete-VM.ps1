Function Remove-VM {
    <#
        .SYNOPSIS
            Removes a virtual machine on a Hyper-V host and deletes the associated virtual hard disks.
 
        .DESCRIPTION
            Removes a virtual machine on a Hyper-V host and deletes the associated virtual hard disks.
            
        .PARAMETER ComputerName
            The hostname of the Hyper-V host where the virtual machine exists.
            Defaults to the local host if not specified.

        .PARAMETER VM
            The virtual machine to delete. Multiple virtual machines can be specified.
            
        .PARAMETER Username
			The username used to connect to a remove Hyper-V server.
        
        .PARAMETER Password
			The password for the username specified.
        
        .PARAMETER CimSession
			A CIM session to a remote host that can be passed to this function for authenticating against a remote host.
  
        .EXAMPLE
            PS C:\> Delete-VM -ComputerName hyperv1 -VM sql1, web1
            
            Rmoves the virtual machines sql1 and web1 from the host hyperv1 and deletes their associated virtual hard disks.
            
        .NOTES
 	        NAME: Delete-VM.ps1
	        VERSION: 1.0
	        AUTHOR: Aaron Parker
	        LASTEDIT: April 15, 2016
 
        .LINK
            http://stealthpuppy.com
    #>
    [CmdletBinding(SupportsShouldProcess = $False, ConfirmImpact = "High", DefaultParameterSetName = "Default")]
    PARAM (
        [Parameter(Mandatory=$False, Position=0, HelpMessage="Specify a host where the target virtual machine exists.")]
        [array]$ComputerName = $env:COMPUTERNAME,

        [Parameter(Mandatory=$True, Position=1, HelpMessage="Specify a virtual machine to delete.")]
        [string[]]$VM,
        
        [Parameter(Mandatory=$False)]
        [string]$Username,
        
        [Parameter(Mandatory=$False)]
        [string]$Password,
        
        [Parameter(Mandatory=$False)]
        [Microsoft.Management.Infrastructure.CimSession]$CimSession        
    )
    
    BEGIN {
        If ($PSBoundParameters['Username']) {
                If ($PSBoundParameters['Password']) {
                    $SecurePassword = ConvertTo-SecureString -String $Password -AsPlainText -Force
                    $cred = New-Object -typename System.Management.Automation.PSCredential -argumentlist $Username, $SecurePassword
                    $cim = New-CimSession -Credential $cred -ComputerName $ComputerName
                }
        }

        If ($PSBoundParameters['CimSession']) {
            $cim = $CimSession
        }
    }
        
    PROCESS {
        ForEach ( $v in $VM ) {
            $machine = Get-VM -CimSession $cim -Name $v -ErrorVariable $Error
            $VHDs = $machine | Get-VMHardDiskDrive
            Invoke-Command -ComputerName $ComputerName -ScriptBlock { param($VHDs) ForEach ( $vhd in $VHDs) { Remove-Item -Path $vhd.Path -Force -Confirm:$False -Verbose } } -Args $VHDs
			$machine | Remove-VM -Force -Verbose
        }
    }
}