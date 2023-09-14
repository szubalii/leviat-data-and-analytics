Write-Host "CommitID:"$commitId

$targetBranch = 'refs/remotes/origin/'+$env:SYSTEM_PULLREQUEST_TARGETBRANCHNAME+'...HEAD'
$extractionsFolder = 'xu-config/extractions/'
$changedFiles = git diff --name-only $targetBranch #$commitId^!

# $changedFiles = 'xu-config/extractions/I_DeliveryDocument/source.json'#,'xu-config/extractions/I_Brand/source.json','xu-config/extractions/I_DeliveryDocument/source.json','xu-config/extractions/I_DeliveryDocument/general.json'

Write-Host "The following file(s) have changed:"
$changedFiles

# If a single file is changed convert to an array
if ($changedFiles.getType().Name -eq 'String') {
  $changedFile = $changedFiles
  $changedFiles = @()
  $changedFiles += $changedFile
}

# Get the changed extraction files
$changedExtractionsFiles = $changedFiles -match $extractionsFolder

# Write-Host "The following extraction files have changed:"
# $changedExtractionsFiles
$extractions = $( foreach ($changedExtractionsFile in $changedExtractionsFiles) {
  $changedExtractionsFile.split('/')[2]
}) | Sort-Object | Get-Unique

# Set to empty array in case of no changed extractions
if ($null -eq $extractions) {
  $extractions = @()
  Write-Host "No extractions have changed"
} else {
  Write-Host "The following extraction(s) have changed:"
  $extractions
}
# Write-Host "`n"
$extractionNames = $extractions -join ',';

#expose list of extractions to other tasks in same job
Write-Host "##vso[task.setvariable variable=changedExtractions]$extractionNames"
