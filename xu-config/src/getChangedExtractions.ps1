Write-Host "CommitID:"$commitId

$targetBranch = 'origin/'+$env:SYSTEM_PULLREQUEST_TARGETBRANCHNAME

$extractionsFolder = 'xu-config/extractions/'
$changedFiles = git diff --name-only $targetBranch #$commitId^!

# $changedFiles = 'xu-config/extractions/I_DeliveryDocument/source.json'#,'xu-config/extractions/I_Brand/source.json','xu-config/extractions/I_DeliveryDocument/source.json','xu-config/extractions/I_DeliveryDocument/general.json'

Write-Host "The following file(s) have changed:"
$changedFiles

Write-Host "Target Branch:"
$env:SYSTEM_PULLREQUEST_TARGETBRANCH

# If a single file is changed convert to an array
if ($changedFiles.getType().Name -eq 'String') {
  $changedFile = $changedFiles
  $changedFiles = @()
  $changedFiles += $changedFile
}

$changedExtractionsFiles = $changedFiles -match $extractionsFolder

# Write-Host "The following extraction files have changed:"
# $changedExtractionsFiles
$extractions = $( foreach ($changedExtractionsFile in $changedExtractionsFiles) {
  $changedExtractionsFile.split('/')[2]
}) | Sort-Object| Get-Unique
# Write-Host "`n"

Write-Host "The following extraction(s) have changed:"
$extractions

# Write-Host "##vso[task.setvariable variable=changedExtractions;isOutput=true]$extractions"

ForEach ($extraction in $extractions) {
  $extractionName = $env:SYSTEM_PULLREQUEST_PULLREQUESTID + '_' + $extraction
  $params = '-s localhost -p 8065 -n '+$extractionName
  $Command = "C:\Program Files\XtractUniversal\xu.exe"
  Invoke-Expression -Command "$Command $params"
}
