<#
.SYNOPSIS
  Creates data disks on one or all virtual machines.
.DESCRIPTION
  Enumarates VMs you have and Adds data disks for improving IO throughput with your VM deployments. 

  Note: This script requires an Azure Storage Account to run.  A storage account can be 
  specified by setting the subscription configuration.  For example:
    Set-AzureSubscription -SubscriptionName "MySubscription" -CurrentStorageAccount "MyStorageAccount"

  Note: There are limits on the number of disks attached to VMs as dictated by their size. 

.EXAMPLE
  .\Create-DataDisksOnVMs.ps1 -VMName MyVMNameORAll -DiskSizeInGB 1023 -NumberOfDisks 4 -HostCarching ReadWrite -MediaLocation http://.../vhds/
#>

param (  
  # VMName that will get the addition disk. Empty will add to all VMs
    [Parameter(Mandatory = $true)]
    [String]$VMName,
  
  # Disk size in GB
    [Parameter(Mandatory = $true)]
    [Int32]$DiskSizeInGB,
    
    # Number of data disks to add to each virtual machine
    [Parameter(Mandatory = $true)]
    [Int32]$NumberOfDisks,

    # Number of data disks to add to each virtual machine
    [Parameter(Mandatory = $true)]
    [String]$HostCaching,

    # Number of data disks to add to each virtual machine
    [Parameter(Mandatory = $true)]
    [String]$MediaLocation
)


# The script has been tested on Powershell 3.0
Set-StrictMode -Version 3

# Following modifies the Write-Verbose behavior to turn the messages on globally for this session
$VerbosePreference = "Continue"

# Check if Windows Azure Powershell is avaiable
if ((Get-Module -ListAvailable Azure) -eq $null)
{
    throw "Windows Azure Powershell not found! Please make sure to install them from http://www.windowsazure.com/en-us/downloads/#cmd-line-tools"
}


For ($lun=0;$lun -le $NumberOfDisks;$lun=$lun+1) 
{
 ForEach ($vm in Get-AzureVM) 
 {
  if (($vm.Name -eq $VMName) -or ($VMName -eq 'All'))
  {
    $label = $vm.name+"_"+$lun
    $media = $MediaLocation+$label+".vhd"
    Add-AzureDataDisk -VM $vm -CreateNew -DiskSizeInGB $DiskSizeInGB -DiskLabel $label -LUN $lun -HostCaching $HostCaching -MediaLocation $media | Update-AzureVM
  }
 }
}
