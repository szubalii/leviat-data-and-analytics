# $MasterDataFilePath = '..\config\global\master-data.json'
# $GlobalParametersFilePath = '..\config\global\global-parameters.json'
# $FieldName = 'document'
# $ContentType = 'text/plain'

# $FileStream = [System.IO.FileStream]::new($filePath, [System.IO.FileMode]::Open)
# $FileHeader = [System.Net.Http.Headers.ContentDispositionHeaderValue]::new('form-data')
# $FileHeader.Name = $FieldName
# $FileHeader.FileName = Split-Path -leaf $FilePath
# $FileContent = [System.Net.Http.StreamContent]::new($FileStream)
# $FileContent.Headers.ContentDisposition = $FileHeader
# $FileContent.Headers.ContentType = [System.Net.Http.Headers.MediaTypeHeaderValue]::Parse($ContentType)

# $MultipartContent = [System.Net.Http.MultipartFormDataContent]::new()
# $MultipartContent.Add($FileContent)

# $Response = Invoke-WebRequest -Body $MultipartContent -Method 'POST' -Uri 'https://api.contoso.com/upload'

param($root) #= '_syndw_xxxx_sls_d_euw_001\Release'

$MasterDataFilePath = $root + '\src\config\global\master-data.json'
$GlobalParametersFilePath = $root + '\src\config\global\global-parameters.json'

# https://docs.microsoft.com/en-us/powershell/module/az.datafactory/invoke-azdatafactoryv2pipeline?view=azps-7.3.0#examples

$MasterDataArray = Get-Content -Raw -Path $MasterDataFilePath | ConvertFrom-Json #[System.Net.Http.StreamContent]::new([System.IO.FileStream]::new($MasterDataFilePath, [System.IO.FileMode]::Open))
$GlobalParameters = Get-Content -Raw -Path $GlobalParametersFilePath | ConvertFrom-Json #[System.Net.Http.StreamContent]::new([System.IO.FileStream]::new($GlobalParametersFilePath, [System.IO.FileMode]::Open))
$resourceGroupName = $GlobalParameters.resourceGroupName #"rg-xxxx-sls-d-euw-001"
$dataFactoryName = $GlobalParameters.dataFactoryName #

# The Invoke-AzDataFactoryV2Pipeline command starts a run on the specified pipeline and returns a ID for that run.
# This GUID can be passed to Get-AzDataFactoryV2PipelineRun or Get-AzDataFactoryV2ActivityRun to obtain further details about this run.
foreach ($masterDataParameters in $MasterDataArray) {

    $masterDataParametersHashTable = @{}
    $masterDataParameters.psobject.properties | ForEach-Object { $masterDataParametersHashTable[$_.Name] = $_.Value }

    $runId = Invoke-AzDataFactoryV2Pipeline `
    -ResourceGroupName $resourceGroupName `
    -DataFactoryName $dataFactoryName `
    -PipelineName "pl_ADLS_SYNDW_flat-files-csv" `
    -Parameter $masterDataParametersHashTable

    $status = Get-AzDataFactoryV2PipelineRun `
    -ResourceGroupName $resourceGroupName `
    -DataFactoryName $dataFactoryName `
    -PipelineRunId $runId

    
}


