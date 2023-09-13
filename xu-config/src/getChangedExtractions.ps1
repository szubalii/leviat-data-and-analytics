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

$changedExtractionsFiles = $changedFiles -match $extractionsFolder

# Write-Host "The following extraction files have changed:"
# $changedExtractionsFiles
$extractions = $( foreach ($changedExtractionsFile in $changedExtractionsFiles) {
  $changedExtractionsFile.split('/')[2]
}) | Sort-Object| Get-Unique
# Write-Host "`n"

Write-Host "The following extraction(s) have changed:"
$extractions

#expose list of extractions to other tasks in same job
Write-Host "##vso[task.setvariable variable=changedExtractions]$extractions"
