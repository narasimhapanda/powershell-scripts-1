Get-AppxPackage | Select Name | Export-Csv -Path AppxPackage.csv
Get-AppxProvisionedPackage -Online | Select DisplayName | Export-Csv -Path AppxProvisionedPackage.csv
Get-AppxPackage -Name Microsoft.WindowsPhone | Get-AppxPackageManifest | % { $_.Package.Properties.PublisherDisplayName }
Get-AppxPackage -Name Microsoft.WindowsPhone | Get-Member
Get-StartApps -Name 'Phone Companion'