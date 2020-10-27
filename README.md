Create multiple data disks on one or all your Azure Virtual Machines
====================================================================

            

 

 

 


The script comes in handy, when you'd like to create multiple data drives of identical size on one or all of your VMs. You can specify the number of data disks and size for each in GB. Specifying a single VM name will apply the gives to the given VM name.
 If you specify 'All' (without the quotes) for VMName, the script cycles through all your VMs and will the data disks of specified number and size to all of your VMs on Azure.


Various VM sizes come with limitations on number and size of disk drives you can attach in Azure. You will get errors if you try to add more disks than allowed number for the VM you are targeting.


        
    
TechNet gallery is retiring! This script was migrated from TechNet script center to GitHub by Microsoft Azure Automation product group. All the Script Center fields like Rating, RatingCount and DownloadCount have been carried over to Github as-is for the migrated scripts only. Note : The Script Center fields will not be applicable for the new repositories created in Github & hence those fields will not show up for new Github repositories.
