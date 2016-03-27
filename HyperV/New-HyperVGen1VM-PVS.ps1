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
    $VMHostName = "hv1"
    $VMHost = Get-VMHost -ComputerName $VMHostName
    $VHDPath = $VMHost.VirtualHardDiskPath
    $vmNetwork = Get-VMHost -ComputerName hv1 | Select-Object -ExpandProperty InternalNetworkAdapters | Select-Object Name

    $memoryStartupBytes = "768MB"
    $newVHDSizeBytes = "64GB"
    $isoPath = "E:\ISOs\LiteTouchPE_x64.iso"
    $bootDevice = "CD"

    $VMName = Read-Host -Prompt "Enter VM name"

    $VM = New-VM –Name $VMName –MemoryStartupBytes $memoryStartupBytes -NewVHDSizeBytes $newVHDSizeBytes -NewVHDPath "$VHDPath\$VMName.vhdx" -BootDevice $bootDevice -Verbose
    Get-VMDvdDrive -VMName $VMName | Remove-VMDvdDrive -Verbose
    Get-VMNetworkAdapter -VMName $VMName | Where-Object {$_.Name -eq "Network Adapter"} | Remove-VMNetworkAdapter -Verbose
    Add-VMNetworkAdapter -VMName $VMName -IsLegacy $True -Name "Legacy Network Adapter" -SwitchName $SwitchName -Verbose
    Set-VM -Name $VMName -AutomaticStartAction Nothing -AutomaticStopAction Shutdown -DynamicMemory -Verbose

} Else {
    Write-Error "Hyper-V module not available. Aborting."
}