[CmdletBinding()] #attribute allows to pass params from Azure Key Vault and Azure Pipelines
param (
	$SharePointUsername,
	$SharePointPassword,
	$SharePointURL,
	$SharePointFolder,
	$AzureRepoFolder
)

#Function to Copy Multiple Files with Folder structure to SharePoint Online
Function UploadFilesToSharePoint() {
    param (
        [Parameter(Mandatory = $true )]
        [ValidateNotNullOrEmpty()]
        [string]$SharePointUsername,
    
        [Parameter(Mandatory = $true )]
        [ValidateNotNullOrEmpty()]
        $SharePointPassword,
        
        [Parameter(Mandatory = $true )]
        [ValidateNotNullOrEmpty()]
        [string]$SharePointURL,
    
        [Parameter(Mandatory = $true )]
        [ValidateNotNullOrEmpty()]
        [string]$SharePointFolder,
    
        [Parameter(Mandatory = $true )]
        [ValidateNotNullOrEmpty()]
        [string]$AzureRepoFolder
    )
    #Install SharePoint Online Module
    Write-host "Installing libraries for Sharepoint Online"
    IF (!(Get-Module -ListAvailable -Name SharePointPnPPowerShellOnline)) {
        Install-Module SharePointPnPPowerShellOnline -SkipPublisherCheck -AllowClobber -Force
    }

    #Connect to PnP Online
    Write-host "Connecting to SharePoint Site: $($SharePointURL)"
    [SecureString]$SecurePass = ConvertTo-SecureString $SharePointPassword -AsPlainText -Force
    [System.Management.Automation.PSCredential]$PSCredentials = New-Object System.Management.Automation.PSCredential($SharePointUsername, $SecurePass)
    Connect-PnPOnline -Url $SharePointURL -Credentials $PSCredentials -WarningAction Ignore

    IF (-not (Get-PnPContext)) {
        Write-host "Error connecting to SharePoint Online, unable to establish context"
        return
    }

    Write-host "Uploading Files from $($AzureRepoFolder)"
    #Get All Items from the Source
    $Source = Get-ChildItem -Path $AzureRepoFolder -Recurse
    $SourceItems = $Source | Select FullName, PSIsContainer, @{Label='TargetItemURL';Expression={$_.FullName.Replace($AzureRepoFolder,$SharePointFolder).Replace("\","/")}}

    #Upload Source Items from Azure repo folder to SharePoint Online
    $Counter = 1
    $SourceItems | ForEach-Object {
        #Get Target Folder URL 
        $TargetFolderURL = (Split-Path $_.TargetItemURL -Parent)
        $ItemName = Split-Path $_.FullName -leaf
        
        IF ($_.PSIsContainer) {
            #Upload Folder
            $Folder  = Resolve-PnPFolder -SiteRelativePath ($TargetFolderURL+"/"+$ItemName)
            Write-host "Uploaded Folder '$($ItemName)' to Folder $TargetFolderURL"
        } ELSE {
            #Upload File
            $File  = Add-PnPFile -Path $_.FullName -Folder $TargetFolderURL
            Write-host "Uploaded File '$($_.FullName)' to Folder $TargetFolderURL"
        }
    $Counter++
    }
}
  
#Call the Function to Upload Mapping Files to SharePoint Online
UploadFilesToSharePoint -SharePointUsername $SharePointUsername -SharePointPassword $SharePointPassword -SharePointURL $SharePointURL -SharePointFolder $SharePointFolder -AzureRepoFolder $AzureRepoFolder