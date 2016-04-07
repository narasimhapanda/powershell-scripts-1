# Move all FSMO roles to the specified server
Move-ADDirectoryServerOperationMasterRole -Identity hv1.home.stealthpuppy.com –OperationMasterRole PDCEmulator,RIDMaster,InfrastructureMaster,SchemaMaster,DomainNamingMaster


Get-ADDomainController -Discover -Service PrimaryDC