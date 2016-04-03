# Updating boot images
Import-Module "$env:ProgramFiles\Microsoft Deployment Toolkit\bin\MicrosoftDeploymentToolkit.psd1"
New-PSDrive -Name "DS001" -PSProvider MDTProvider -Root "\\mcfly\Deployment\Automata"
Update-MDTDeploymentShare -path "DS001:" -Force -Verbose

# New task sequence
Import-Module "C:\Program Files\Microsoft Deployment Toolkit\bin\MicrosoftDeploymentToolkit.psd1"
New-PSDrive -Name "DS002" -PSProvider MDTProvider -Root "\\MCFLY\Deployment\Reference"
import-mdttasksequence -path "DS002:\Task Sequences\Vanilla OS" -Name "Windows Server" -Template "Server.xml" -Comments "" -ID "001" -Version "1.0" -OperatingSystemPath "DS002:\Operating Systems\Volume License\Windows Server 2012\Windows Server 2012 SERVERSTANDARDCORE in Windows Server 2012 VL install.wim" -FullName "stealthpuppy" -OrgName "stealthpuppy" -HomePage "about:blank" -Verbose
