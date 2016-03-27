Function Get-AvailableModule {
    Param ([string]$Name)
    If ( -Not (Get-Module -Name $Name)) {
        If (Get-Module -ListAvailable | Where-Object { $_.Name -eq $Name }) {
            Import-Module -Name $Name
            Return $True
            # If module available then import
        } Else {
            Return $False
            # Module not available
        }
    } Else {
        Return $True
        # Module already loaded
    }
} #End Function

If (Get-AvailableModule -Name "Hyper-V") {
    $vmHostName = Read-Host -Prompt "Enter host name"
    $vmHost = Get-VMHost -ComputerName $vmHostName
    $vhdPath = $VMHost.VirtualHardDiskPath
    $vmNetwork = $vmHost | Select-Object -ExpandProperty InternalNetworkAdapters | Select-Object Name

    $memoryStartupBytes = 768MB
    $newVHDSizeBytes = 64GB
    $isoPath = "E:\ISOs\LiteTouchPE_x86.iso"
    $bootDevice = "CD"

    $VMName = Read-Host -Prompt "Enter VM name"

    $VM = New-VM -ComputerName $VMHostName –Name $VMName –MemoryStartupBytes $memoryStartupBytes -NewVHDSizeBytes $newVHDSizeBytes -NewVHDPath "$VHDPath\$VMName.vhdx" -SwitchName $vmNetwork.Name -Generation 1 -BootDevice $bootDevice -Verbose
    $VM | Set-VM -ProcessorCount 2 -AutomaticStartAction Nothing -AutomaticStopAction Shutdown -DynamicMemory -Verbose
    $VM | Get-VMDvdDrive | Set-VMDvdDrive -Path $isoPath

} Else {
    Write-Error "Hyper-V module not available. Aborting."
}