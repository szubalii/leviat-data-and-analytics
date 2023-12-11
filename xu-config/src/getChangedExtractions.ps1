# Write-Host "CommitID:"$commitId

$targetBranch = 'refs/remotes/origin/'+$env:SYSTEM_PULLREQUEST_TARGETBRANCHNAME+'...HEAD'
$extractionsFolder = 'xu-config/extractions/'

# exclude deleted files
$changedFiles = git diff --name-only --diff-filter=d $targetBranch #$commitId^!

# $changedFiles = 'xu-config/extractions/I_DeliveryDocument/source.json'#,'xu-config/extractions/I_Brand/source.json','xu-config/extractions/I_DeliveryDocument/source.json','xu-config/extractions/I_DeliveryDocument/general.json'

Write-Host "The following file(s) have changed (excl. deleted ones):"
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

if ($null -eq $extractions) {
  # $extractions = @()
  Write-Host "No extractions have changed"
} else {
  Write-Host "The following extraction(s) have changed (excl. deleted ones):"
  $extractions
  # Convert to comma separated list of extraction names
  $extractionNames = $extractions -join ',';
  #expose list of extractions to other tasks in same job
  Write-Host "##vso[task.setvariable variable=changedExtractions]$extractionNames"
}
# Write-Host "`n"
