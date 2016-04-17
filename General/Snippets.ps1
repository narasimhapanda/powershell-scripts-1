# Find used space on the C: drive
$Drive = Get-WmiObject Win32_LogicalDisk | Where-Object { $_.DeviceID -eq $env:SystemDrive }
$UsedSpace = ($Drive.Size - $Drive.FreeSpace)/1GB
Write-Host $UsedSpace