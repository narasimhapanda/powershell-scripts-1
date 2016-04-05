$Username = "Administrator"
$Password = "Passw0rd"
$SPassword = convertto-securestring -String $Password -AsPlainText -Force
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $Username, $SPassword
# $cred = Get-Credential -UserName Administrator -Message "Please enter the password."
$nuc1 = New-CimSession -Credential $cred -ComputerName nuc1

$vmHostName = Read-Host -Prompt "Enter host name"
$vmName = Read-Host -Prompt "Enter VM name"
$vm = Get-VM -CimSession $nuc1 -Name $vmName
# $vm = Get-VM -ComputerName $vmHostName -Name $vmName
$VHDs = $vm | Get-VMHardDiskDrive
Invoke-Command -ComputerName $vmHostName -ScriptBlock { param($VHDs) ForEach ( $vhd in $VHDs) { Remove-Item -Path $vhd.Path -Force -Confirm:$False -Verbose } } -Args $VHDs
$vm | Remove-VM -Force -Verbose
