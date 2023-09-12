param (
  [string]$commitId
)

Write-Host "CommitID:"$commitId

$extractionsFolder = 'xu-config/extractions/'
$changedFiles = git diff --name-only $SYSTEM_PULLREQUEST_TARGETBRANCH #$commitId^!

# $changedFiles = 'xu-config/extractions/I_DeliveryDocument/source.json'#,'xu-config/extractions/I_Brand/source.json','xu-config/extractions/I_DeliveryDocument/source.json','xu-config/extractions/I_DeliveryDocument/general.json'

Write-Host "The following file(s) have changed:"
$changedFiles

# If a single file is changed
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
