# Move all FSMO roles to the specified server
Move-ADDirectoryServerOperationMasterRole -Identity hv1.home.stealthpuppy.com –OperationMasterRole PDCEmulator,RIDMaster,InfrastructureMaster,SchemaMaster,DomainNamingMaster

# Get FSMO roles from AD
Get-ADDomainController -Discover -Service PrimaryDC