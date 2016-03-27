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
    $VMHostName = Read-Host -Prompt "Enter host name"
    $VMHost = Get-VMHost -ComputerName $VMHostName
    $VHDPath = $VMHost.VirtualHardDiskPath
    # $vmNetwork = $VMHost | Select-Object -ExpandProperty ExternalNetworkAdapters | Select-Object Name

    $memoryStartupBytes = 768MB
    $newVHDSizeBytes = 64GB
    $isoPath = "C:\ISOs\LiteTouchPE_x64.iso"
    $bootDevice = "CD"

    $VMName = Read-Host -Prompt "Enter VM name"

    $VM = New-VM -ComputerName $VMHostName –Name $VMName –MemoryStartupBytes $memoryStartupBytes -NewVHDSizeBytes $newVHDSizeBytes -NewVHDPath "$VHDPath$VMName.vhdx" -SwitchName $VMHost.ExternalNetworkAdapters[0].Name -Generation 2 -BootDevice $bootDevice -Verbose
    $VM | Set-VM -ProcessorCount 2 -AutomaticStartAction Nothing -AutomaticStopAction Shutdown -DynamicMemory -Verbose
    $VM | Get-VMDvdDrive | Set-VMDvdDrive -Path $isoPath
    $DVD = ($VM | Get-VMDvdDrive)
    $VM | Set-VMFirmware -FirstBootDevice $DVD -EnableSecureBoot Off

} Else {
    Write-Error "Hyper-V module not available. Aborting."
}


