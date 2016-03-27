# 
# Get Machines
# 
# 6/05/2014 2:43 AM
# 
Get-BrokerMachine  -AdminAddress 'xd71.home.stealthpuppy.com:80' -Filter '(SessionSupport -eq `"SingleSession`")' -MaxRecordCount 500 -Property @('DNSName','CatalogName','DesktopGroupName','AssociatedUserNames','InMaintenanceMode','PersistUserChanges','PowerState','RegistrationState','MachineName','Uid','DesktopUid','DesktopKind','HypervisorConnectionUid','CatalogUid','DesktopGroupUid','Capabilities','SupportedPowerActions') -ReturnTotalRecordCount -Skip 0 -SortBy '+DNSName'
# Get-BrokerMachine : Returned 10 of 10 items
# 
# 	+ CategoryInfo : OperationStopped: (:) [Get-BrokerMachine], PartialDataException
# 	+ FullyQualifiedErrorId : Citrix.XDPowerShell.Broker.PartialData,Citrix.Broker.Admin.SDK.GetBrokerMachineCommand
# Script completed successfully

# 
# Create Machine Catalog 'Windows 7'
# 
# 6/05/2014 2:59 AM
# 
Get-ConfigServiceStatus  -AdminAddress 'xd71.home.stealthpuppy.com:80'

Get-LogSite  -AdminAddress 'xd71.home.stealthpuppy.com:80'

Start-LogHighLevelOperation  -AdminAddress 'xd71.home.stealthpuppy.com:80' -Source 'Studio' -StartTime 5/05/2014 4:57:57 PM -Text 'Create Machine Catalog `'Windows 7`''

New-BrokerCatalog  -AdminAddress 'xd71.home.stealthpuppy.com:80' -AllocationType 'Random' -Description 'Windows 7 x86' -IsRemotePC $False -LoggingId 8f7e2e72-07e1-4b86-9c15-7b531f459f6f -MachinesArePhysical $False -MinimumFunctionalLevel 'L7' -Name 'Windows 7' -PersistUserChanges 'OnLocal' -ProvisioningType 'Manual' -Scope @() -SessionSupport 'SingleSession'

Set-HypAdminConnection  -AdminAddress 'xd71.home.stealthpuppy.com:80'

Get-ChildItem  -LiteralPath @('XDHyp:\Connections')

Get-BrokerHypervisorConnection  -AdminAddress 'xd71.home.stealthpuppy.com:80' -MaxRecordCount 2147483647

New-BrokerMachine  -AdminAddress 'xd71.home.stealthpuppy.com:80' -CatalogUid 14 -HostedMachineId 'f6c23543-8926-4b20-841a-d1f868a65fa1' -HypervisorConnectionUid 5 -LoggingId 8f7e2e72-07e1-4b86-9c15-7b531f459f6f -MachineName 'S-1-5-21-733536048-680991148-2551668650-2702'

Get-BrokerCatalog  -AdminAddress 'xd71.home.stealthpuppy.com:80' -Uid 14

Stop-LogHighLevelOperation  -AdminAddress 'xd71.home.stealthpuppy.com:80' -EndTime 5/05/2014 4:59:26 PM -HighLevelOperationId '8f7e2e72-07e1-4b86-9c15-7b531f459f6f' -IsSuccessful $True
# Script completed successfully

