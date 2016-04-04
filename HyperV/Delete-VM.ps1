$vmHostName = Read-Host -Prompt "Enter host name"
$vmName = Read-Host -Prompt "Enter VM name"
$vm = Get-VM -ComputerName $vmHostName -Name $vmName
$VHDs = $vm | Get-VMHardDiskDrive
Invoke-Command -ComputerName $vmHostName -ScriptBlock { param($VHDs) ForEach ( $vhd in $VHDs) { Remove-Item -Path $vhd.Path -Force -Confirm:$False -Verbose } } -Args $VHDs
$vm | Remove-VM -Force -Verbose
