#
# Windows PowerShell script for AD DS Deployment
#

Import-Module ADDSDeployment
Install-ADDSDomainController `
-NoGlobalCatalog:$false `
-Credential (Get-Credential) `
-CriticalReplicationOnly:$false `
-DatabasePath "C:\windows\NTDS" `
-DomainName "home.stealthpuppy.com" `
-InstallDns:$false `
-LogPath "C:\windows\NTDS" `
-NoRebootOnCompletion:$false `
-ReplicationSourceDC "HV1.home.stealthpuppy.com" `
-SiteName "Home" `
-SysvolPath "C:\windows\SYSVOL" `
-Force:$true

Get-ADDomainController -Discover -Service PrimaryDC


# ---------

#
# Windows PowerShell script for AD DS Deployment
#

Import-Module ADDSDeployment
Install-ADDSDomainController `
-NoGlobalCatalog:$false `
-CreateDnsDelegation:$false `
-Credential (Get-Credential) `
-CriticalReplicationOnly:$false `
-DatabasePath "C:\windows\NTDS" `
-DomainName "home.stealthpuppy.com" `
-InstallDns:$true `
-LogPath "C:\windows\NTDS" `
-NoRebootOnCompletion:$false `
-SiteName "Home" `
-SysvolPath "C:\windows\SYSVOL" `
-Force:$true

