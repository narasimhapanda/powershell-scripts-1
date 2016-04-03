# Authenticate to the remote host
$cred = Get-Credential -UserName .\Administrator -Message "Please enter the password."
$cimsession = New-CimSession -Credential $cred -ComputerName nuc1

# Get configuration from remote host
$VmHost = Get-VMHost -CimSession $cimsession | Select * | Format-List

$VmHost.VirtualHardDiskPath
$VmHost.VirtualMachinePath


# Set default folders

Machines
Virtual Hard Disks
Checkpoints
Smart Paging File