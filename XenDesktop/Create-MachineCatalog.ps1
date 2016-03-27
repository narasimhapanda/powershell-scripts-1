# 
# Create Machine Catalog 'Windows 7 x86'
# 
# 26/04/2013 13:13
# 
$XenDesktopDDC = "ctx-ex-ddc.ucs-poc.co.uk:80"
$XenDesktopController = "ctx-ex-ddc.ucs-poc.co.uk"

## Get-ConfigServiceStatus -AdminAddress $XenDesktopDDC
## Get-LogSite -AdminAddress $XenDesktopDDC

# Start-LogHighLevelOperation -AdminAddress $XenDesktopDDC -Source 'Studio' -StartTime 26/04/2013 12:10:22 -Text 'Create Machine Catalog `'Windows 7 x86`''

$Catalog = New-BrokerCatalog -AdminAddress $XenDesktopDDC -AllocationType 'Random' -Description 'Windows 7 x86' -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -Name 'Windows 7 x86' -PersistUserChanges 'Discard' -ProvisioningType 'MCS' -PvsForVM @() -Scope @() -SessionSupport 'SingleSession'
$AccIdentPool = New-AcctIdentityPool -AdminAddress $XenDesktopDDC -AllowUnicode -Domain 'UCS-POC.CO.UK' -IdentityPoolName 'Windows 7 x86' -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -NamingScheme 'W7-EX-###' -NamingSchemeType 'Numeric' -OU 'OU=Desktops,OU=Excalibur,OU=Desktop Virtualization,DC=UCS-POC,DC=CO,DC=UK' -Scope @()

## Get-ConfigServiceGroup -AdminAddress $XenDesktopDDC -MaxRecordCount 2147483647 -ServiceType 'Broker'

Add-ConfigServiceGroupMetadata -AdminAddress $XenDesktopDDC -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -Name 'Citrix_DesktopStudio_BrokerCatalogIdentityPoolReferencePrefix_5' -ServiceGroupUid 18549ebc-bbe6-4084-81aa-87b50dc15a46 -Value '1fef2a82-d8a7-41c3-bc82-c2c7b3a0ad62'
New-HypVMSnapshot -AdminAddress $XenDesktopDDC -LiteralPath 'XDHyp:\hostingunits\ILIO SSD storage\Win7-x86-VDA-Template.vm' -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -SnapshotName 'Citrix_XD_Windows 7 x86'
New-ProvScheme -AdminAddress $XenDesktopDDC -CleanOnBoot -HostingUnitName 'ILIO SSD storage' -IdentityPoolName 'Windows 7 x86' -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -MasterImageVM 'XDHyp:\hostingunits\ILIO SSD storage\Win7-x86-VDA-Template.vm\Citrix_XD_Windows 7 x86.snapshot' -ProvisioningSchemeName 'Windows 7 x86' -RunAsynchronously -Scope @() -VMCpuCount 2 -VMMemoryMB 2048

## Get-ProvTask -AdminAddress $XenDesktopDDC -Filter '(TaskId -eq `"b7cf458f-16ae-455d-bbc0-ad76f26219a6`")' -MaxRecordCount 2147483647 -Skip 0 -SortBy '+DateStarted'

Add-ProvTaskMetadata -AdminAddress $XenDesktopDDC -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -Name 'Citrix_DesktopStudio_TaskGroupId' -TaskId b7cf458f-16ae-455d-bbc0-ad76f26219a6 -Value 'e12fddaf-a5f3-4146-8389-214e2154872a'
Add-ProvTaskMetadata -AdminAddress $XenDesktopDDC -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -Name 'Citrix_DesktopStudio_DesktopCatalogId' -TaskId b7cf458f-16ae-455d-bbc0-ad76f26219a6 -Value '5'
Remove-ProvTaskMetadata -AdminAddress $XenDesktopDDC -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -Name 'Citrix_DesktopStudio_DesktopCatalogId' -TaskId b7cf458f-16ae-455d-bbc0-ad76f26219a6
Add-ProvTaskMetadata -AdminAddress $XenDesktopDDC -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -Name 'Citrix_DesktopStudio_DesktopCatalogId' -TaskId b7cf458f-16ae-455d-bbc0-ad76f26219a6 -Value '5'
Add-ProvTaskMetadata -AdminAddress $XenDesktopDDC -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -Name 'Citrix_DesktopStudio_VMsToCreateCount' -TaskId b7cf458f-16ae-455d-bbc0-ad76f26219a6 -Value '5'
Remove-ProvTaskMetadata -AdminAddress $XenDesktopDDC -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -Name 'Citrix_DesktopStudio_VMsToCreateCount' -TaskId b7cf458f-16ae-455d-bbc0-ad76f26219a6
Add-ProvTaskMetadata -AdminAddress $XenDesktopDDC -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -Name 'Citrix_DesktopStudio_VMsToCreateCount' -TaskId b7cf458f-16ae-455d-bbc0-ad76f26219a6 -Value '5'
Add-ProvTaskMetadata -AdminAddress $XenDesktopDDC -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -Name 'Citrix_DesktopStudio_StartTime' -TaskId b7cf458f-16ae-455d-bbc0-ad76f26219a6 -Value '635025786226325953'
Remove-ProvTaskMetadata -AdminAddress $XenDesktopDDC -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -Name 'Citrix_DesktopStudio_StartTime' -TaskId b7cf458f-16ae-455d-bbc0-ad76f26219a6
Add-ProvTaskMetadata -AdminAddress $XenDesktopDDC -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -Name 'Citrix_DesktopStudio_StartTime' -TaskId b7cf458f-16ae-455d-bbc0-ad76f26219a6 -Value '635025786226325953'

## Get-ProvTask -AdminAddress $XenDesktopDDC -Filter '(TaskId -eq `"b7cf458f-16ae-455d-bbc0-ad76f26219a6`")' -MaxRecordCount 2147483647 -Skip 0 -SortBy '+DateStarted'

## Get-BrokerCatalog -AdminAddress $XenDesktopDDC -Uid 5

## Get-ProvTask -AdminAddress $XenDesktopDDC -Filter '(TaskId -eq `"b7cf458f-16ae-455d-bbc0-ad76f26219a6`")' -MaxRecordCount 2147483647 -Skip 0 -SortBy '+DateStarted'

## Get-BrokerCatalog -AdminAddress $XenDesktopDDC -Uid 5

## Get-ProvTask -AdminAddress $XenDesktopDDC -Filter '(TaskId -eq `"b7cf458f-16ae-455d-bbc0-ad76f26219a6`")' -MaxRecordCount 2147483647 -Skip 0 -SortBy '+DateStarted'

## Get-BrokerCatalog -AdminAddress $XenDesktopDDC -Uid 5

## Get-ProvTask -AdminAddress $XenDesktopDDC -Filter '(TaskId -eq `"b7cf458f-16ae-455d-bbc0-ad76f26219a6`")' -MaxRecordCount 2147483647 -Skip 0 -SortBy '+DateStarted'

## Get-BrokerCatalog -AdminAddress $XenDesktopDDC -Uid 5

## Get-ProvTask -AdminAddress $XenDesktopDDC -Filter '(TaskId -eq `"b7cf458f-16ae-455d-bbc0-ad76f26219a6`")' -MaxRecordCount 2147483647 -Skip 0 -SortBy '+DateStarted'

## Get-BrokerCatalog -AdminAddress $XenDesktopDDC -Uid 5

## Get-ProvTask -AdminAddress $XenDesktopDDC -Filter '(TaskId -eq `"b7cf458f-16ae-455d-bbc0-ad76f26219a6`")' -MaxRecordCount 2147483647 -Skip 0 -SortBy '+DateStarted'

## Get-BrokerCatalog -AdminAddress $XenDesktopDDC -Uid 5

## Get-ProvTask -AdminAddress $XenDesktopDDC -Filter '(TaskId -eq `"b7cf458f-16ae-455d-bbc0-ad76f26219a6`")' -MaxRecordCount 2147483647 -Skip 0 -SortBy '+DateStarted'

## Get-BrokerCatalog -AdminAddress $XenDesktopDDC -Uid 5

## Get-ProvTask -AdminAddress $XenDesktopDDC -Filter '(TaskId -eq `"b7cf458f-16ae-455d-bbc0-ad76f26219a6`")' -MaxRecordCount 2147483647 -Skip 0 -SortBy '+DateStarted'

## Get-BrokerCatalog -AdminAddress $XenDesktopDDC -Uid 5

## Get-ProvTask -AdminAddress $XenDesktopDDC -Filter '(TaskId -eq `"b7cf458f-16ae-455d-bbc0-ad76f26219a6`")' -MaxRecordCount 2147483647 -Skip 0 -SortBy '+DateStarted'

## Get-BrokerCatalog -AdminAddress $XenDesktopDDC -Uid 5

## Get-ProvTask -AdminAddress $XenDesktopDDC -Filter '(TaskId -eq `"b7cf458f-16ae-455d-bbc0-ad76f26219a6`")' -MaxRecordCount 2147483647 -Skip 0 -SortBy '+DateStarted'

## Get-BrokerCatalog -AdminAddress $XenDesktopDDC -Uid 5

## Get-ProvTask -AdminAddress $XenDesktopDDC -Filter '(TaskId -eq `"b7cf458f-16ae-455d-bbc0-ad76f26219a6`")' -MaxRecordCount 2147483647 -Skip 0 -SortBy '+DateStarted'

## Get-BrokerCatalog -AdminAddress $XenDesktopDDC -Uid 5

## Get-ProvTask -AdminAddress $XenDesktopDDC -Filter '(TaskId -eq `"b7cf458f-16ae-455d-bbc0-ad76f26219a6`")' -MaxRecordCount 2147483647 -Skip 0 -SortBy '+DateStarted'

## Get-BrokerCatalog -AdminAddress $XenDesktopDDC -Uid 5

## Get-ProvTask -AdminAddress $XenDesktopDDC -Filter '(TaskId -eq `"b7cf458f-16ae-455d-bbc0-ad76f26219a6`")' -MaxRecordCount 2147483647 -Skip 0 -SortBy '+DateStarted'

## Get-BrokerCatalog -AdminAddress $XenDesktopDDC -Uid 5

## Get-ProvTask -AdminAddress $XenDesktopDDC -Filter '(TaskId -eq `"b7cf458f-16ae-455d-bbc0-ad76f26219a6`")' -MaxRecordCount 2147483647 -Skip 0 -SortBy '+DateStarted'

## Get-BrokerCatalog -AdminAddress $XenDesktopDDC -Uid 5

## Get-ProvTask -AdminAddress $XenDesktopDDC -Filter '(TaskId -eq `"b7cf458f-16ae-455d-bbc0-ad76f26219a6`")' -MaxRecordCount 2147483647 -Skip 0 -SortBy '+DateStarted'

## Get-BrokerCatalog -AdminAddress $XenDesktopDDC -Uid 5

## Get-ProvTask -AdminAddress $XenDesktopDDC -Filter '(TaskId -eq `"b7cf458f-16ae-455d-bbc0-ad76f26219a6`")' -MaxRecordCount 2147483647 -Skip 0 -SortBy '+DateStarted'

## Get-BrokerCatalog -AdminAddress $XenDesktopDDC -Uid 5

## Get-ProvTask -AdminAddress $XenDesktopDDC -Filter '(TaskId -eq `"b7cf458f-16ae-455d-bbc0-ad76f26219a6`")' -MaxRecordCount 2147483647 -Skip 0 -SortBy '+DateStarted'

## Get-BrokerCatalog -AdminAddress $XenDesktopDDC -Uid 5

## Get-ProvTask -AdminAddress $XenDesktopDDC -Filter '(TaskId -eq `"b7cf458f-16ae-455d-bbc0-ad76f26219a6`")' -MaxRecordCount 2147483647 -Skip 0 -SortBy '+DateStarted'

## Get-BrokerCatalog -AdminAddress $XenDesktopDDC -Uid 5

## Get-ProvTask -AdminAddress $XenDesktopDDC -MaxRecordCount 2147483647 -TaskId b7cf458f-16ae-455d-bbc0-ad76f26219a6

Set-BrokerCatalog -AdminAddress $XenDesktopDDC -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -Name 'Windows 7 x86' -PvsForVM @('7d570cee-786d-4f3a-8d2e-f802a4a9860a:00000000-0000-0000-0000-000000000000')

## Get-ChildItem -AdminAddress $XenDesktopDDC -Path @('xdhyp:\connections')

## Get-BrokerHypervisorConnection -AdminAddress $XenDesktopDDC -MaxRecordCount 2147483647

## Get-AcctADAccount -AdminAddress $XenDesktopDDC -IdentityPoolUid 00000000-0000-0000-0000-000000000000 -Lock $False -MaxRecordCount 2147483647 -State 'Available'

New-AcctADAccount -AdminAddress $XenDesktopDDC -Count 5 -IdentityPoolName 'Windows 7 x86' -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c
Add-ProvSchemeControllerAddress -AdminAddress $XenDesktopDDC -ControllerAddress @($XenDesktopController) -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -ProvisioningSchemeName 'Windows 7 x86'
New-ProvVM  -ADAccountName @('UCS-POC\W7-EX-001$','UCS-POC\W7-EX-002$','UCS-POC\W7-EX-003$','UCS-POC\W7-EX-004$','UCS-POC\W7-EX-005$') -AdminAddress $XenDesktopDDC -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -ProvisioningSchemeName 'Windows 7 x86' -RunAsynchronously

## Get-ProvTask -AdminAddress $XenDesktopDDC -Filter '(TaskId -eq `"55c63a4b-8550-43f7-8fcd-9041b26027bd`")' -MaxRecordCount 2147483647 -Skip 0 -SortBy '+DateStarted'

# Add-ProvTaskMetadata -AdminAddress $XenDesktopDDC -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -Name 'Citrix_DesktopStudio_TaskGroupId' -TaskId 55c63a4b-8550-43f7-8fcd-9041b26027bd -Value 'e12fddaf-a5f3-4146-8389-214e2154872a'

## Get-ProvTask -AdminAddress $XenDesktopDDC -Filter '(TaskId -eq `"55c63a4b-8550-43f7-8fcd-9041b26027bd`")' -MaxRecordCount 2147483647 -Skip 0 -SortBy '+DateStarted'

## Get-ProvTask -AdminAddress $XenDesktopDDC -Filter '(TaskId -eq `"55c63a4b-8550-43f7-8fcd-9041b26027bd`")' -MaxRecordCount 2147483647 -Skip 0 -SortBy '+DateStarted'

## Get-ProvTask -AdminAddress $XenDesktopDDC -Filter '(TaskId -eq `"55c63a4b-8550-43f7-8fcd-9041b26027bd`")' -MaxRecordCount 2147483647 -Skip 0 -SortBy '+DateStarted'

## Get-ProvTask -AdminAddress $XenDesktopDDC -Filter '(TaskId -eq `"55c63a4b-8550-43f7-8fcd-9041b26027bd`")' -MaxRecordCount 2147483647 -Skip 0 -SortBy '+DateStarted'

## Get-ProvTask -AdminAddress $XenDesktopDDC -Filter '(TaskId -eq `"55c63a4b-8550-43f7-8fcd-9041b26027bd`")' -MaxRecordCount 2147483647 -Skip 0 -SortBy '+DateStarted'

## Get-ProvTask -AdminAddress $XenDesktopDDC -Filter '(TaskId -eq `"55c63a4b-8550-43f7-8fcd-9041b26027bd`")' -MaxRecordCount 2147483647 -Skip 0 -SortBy '+DateStarted'

## Get-ProvTask -AdminAddress $XenDesktopDDC -Filter '(TaskId -eq `"55c63a4b-8550-43f7-8fcd-9041b26027bd`")' -MaxRecordCount 2147483647 -Skip 0 -SortBy '+DateStarted'

## Get-ProvTask -AdminAddress $XenDesktopDDC -Filter '(TaskId -eq `"55c63a4b-8550-43f7-8fcd-9041b26027bd`")' -MaxRecordCount 2147483647 -Skip 0 -SortBy '+DateStarted'

## Get-ProvTask -AdminAddress $XenDesktopDDC -Filter '(TaskId -eq `"55c63a4b-8550-43f7-8fcd-9041b26027bd`")' -MaxRecordCount 2147483647 -Skip 0 -SortBy '+DateStarted'

# !! Need to get VM Ids
Lock-ProvVM -AdminAddress $XenDesktopDDC -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -ProvisioningSchemeName 'Windows 7 x86' -Tag 'Brokered' -VMID @('4203a5bf-c54d-caeb-5487-fdd0695f5e34','4203f2ce-1e1a-066b-8148-ba73f885e53e','42037835-e54f-47c0-d4a1-80539c522e49','4203e2d1-c7a2-df7c-341f-d2fd3363cd95','42035e01-4da6-a586-efbf-6602ee36ebdc')

## Get-Item -AdminAddress $XenDesktopDDC -Path @('xdhyp:\connections\UCS vCenter 5')

## Get-BrokerHypervisorConnection -AdminAddress $XenDesktopDDC -HypHypervisorConnectionUid 1421b97c-f541-4e1b-9024-0ff22c9516b5 -MaxRecordCount 2147483647

# !! Get machine SIDs
New-BrokerMachine -AdminAddress $XenDesktopDDC -CatalogUid 5 -HostedMachineId '4203a5bf-c54d-caeb-5487-fdd0695f5e34' -HypervisorConnectionUid 2 -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -MachineName 'S-1-5-21-762888873-3368873510-327866540-1290'
New-BrokerMachine -AdminAddress $XenDesktopDDC -CatalogUid 5 -HostedMachineId '4203f2ce-1e1a-066b-8148-ba73f885e53e' -HypervisorConnectionUid 2 -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -MachineName 'S-1-5-21-762888873-3368873510-327866540-1289'
New-BrokerMachine -AdminAddress $XenDesktopDDC -CatalogUid 5 -HostedMachineId '42037835-e54f-47c0-d4a1-80539c522e49' -HypervisorConnectionUid 2 -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -MachineName 'S-1-5-21-762888873-3368873510-327866540-1291'
New-BrokerMachine -AdminAddress $XenDesktopDDC -CatalogUid 5 -HostedMachineId '4203e2d1-c7a2-df7c-341f-d2fd3363cd95' -HypervisorConnectionUid 2 -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -MachineName 'S-1-5-21-762888873-3368873510-327866540-1292'
New-BrokerMachine -AdminAddress $XenDesktopDDC -CatalogUid 5 -HostedMachineId '42035e01-4da6-a586-efbf-6602ee36ebdc' -HypervisorConnectionUid 2 -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -MachineName 'S-1-5-21-762888873-3368873510-327866540-1288'

## Get-ProvTask -AdminAddress $XenDesktopDDC -Filter '(TaskId -eq `"b7cf458f-16ae-455d-bbc0-ad76f26219a6`" -or TaskId -eq `"55c63a4b-8550-43f7-8fcd-9041b26027bd`")' -MaxRecordCount 2147483647 -Skip 0 -SortBy '+DateStarted'

Add-ProvTaskMetadata -AdminAddress $XenDesktopDDC -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -Name 'Citrix_DesktopStudio_TimeTaken' -TaskId b7cf458f-16ae-455d-bbc0-ad76f26219a6 -Value '1542842446'
Remove-ProvTaskMetadata -AdminAddress $XenDesktopDDC -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -Name 'Citrix_DesktopStudio_TimeTaken' -TaskId b7cf458f-16ae-455d-bbc0-ad76f26219a6
Add-ProvTaskMetadata -AdminAddress $XenDesktopDDC -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -Name 'Citrix_DesktopStudio_TimeTaken' -TaskId b7cf458f-16ae-455d-bbc0-ad76f26219a6 -Value '1542842446'
Add-ProvTaskMetadata -AdminAddress $XenDesktopDDC -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -Name 'Citrix_DesktopStudio_DesktopCatalogId' -TaskId 55c63a4b-8550-43f7-8fcd-9041b26027bd -Value '5'
Remove-ProvTaskMetadata -AdminAddress $XenDesktopDDC -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -Name 'Citrix_DesktopStudio_DesktopCatalogId' -TaskId 55c63a4b-8550-43f7-8fcd-9041b26027bd
Add-ProvTaskMetadata -AdminAddress $XenDesktopDDC -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -Name 'Citrix_DesktopStudio_DesktopCatalogId' -TaskId 55c63a4b-8550-43f7-8fcd-9041b26027bd -Value '5'
Add-ProvTaskMetadata -AdminAddress $XenDesktopDDC -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -Name 'Citrix_DesktopStudio_VMsToCreateCount' -TaskId 55c63a4b-8550-43f7-8fcd-9041b26027bd -Value '5'
Remove-ProvTaskMetadata -AdminAddress $XenDesktopDDC -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -Name 'Citrix_DesktopStudio_VMsToCreateCount' -TaskId 55c63a4b-8550-43f7-8fcd-9041b26027bd
Add-ProvTaskMetadata -AdminAddress $XenDesktopDDC -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -Name 'Citrix_DesktopStudio_VMsToCreateCount' -TaskId 55c63a4b-8550-43f7-8fcd-9041b26027bd -Value '5'
Add-ProvTaskMetadata -AdminAddress $XenDesktopDDC -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -Name 'Citrix_DesktopStudio_StartTime' -TaskId 55c63a4b-8550-43f7-8fcd-9041b26027bd -Value '635025786226325953'
Remove-ProvTaskMetadata -AdminAddress $XenDesktopDDC -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -Name 'Citrix_DesktopStudio_StartTime' -TaskId 55c63a4b-8550-43f7-8fcd-9041b26027bd
Add-ProvTaskMetadata -AdminAddress $XenDesktopDDC -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -Name 'Citrix_DesktopStudio_StartTime' -TaskId 55c63a4b-8550-43f7-8fcd-9041b26027bd -Value '635025786226325953'
Add-ProvTaskMetadata -AdminAddress $XenDesktopDDC -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -Name 'Citrix_DesktopStudio_TimeTaken' -TaskId 55c63a4b-8550-43f7-8fcd-9041b26027bd -Value '1542842446'
Remove-ProvTaskMetadata -AdminAddress $XenDesktopDDC -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -Name 'Citrix_DesktopStudio_TimeTaken' -TaskId 55c63a4b-8550-43f7-8fcd-9041b26027bd
Add-ProvTaskMetadata -AdminAddress $XenDesktopDDC -LoggingId 2b6291b2-275d-4be0-a7e7-cf25b654774c -Name 'Citrix_DesktopStudio_TimeTaken' -TaskId 55c63a4b-8550-43f7-8fcd-9041b26027bd -Value '1542842446'
# Script completed successfully

