param (
  [string]$commitId
)

Write-Host "CommitID:"$commitId

$extractionsFolder = 'xu-config/extractions/'
$changedFiles = git diff --name-only $commitId^!

# $changedFiles = 'xu-config/test/I_DeliveryDocument/source.json','xu-config/extractions/I_Brand/source.json','xu-config/extractions/I_DeliveryDocument/source.json','xu-config/extractions/I_DeliveryDocument/general.json'

$changedExtractionsFiles = $changedFiles -match $extractionsFolder

# Write-Host "The following extraction files have changed:"
# $changedExtractionsFiles
$extractions = $( foreach ($changedExtractionsFile in $changedExtractionsFiles) {
  $changedExtractionsFile.split('/')[2]
}) | Sort-Object| Get-Unique
# Write-Host "`n"

Write-Host "The following extraction(s) have changed:"
$extractions

# # If a single file is changed
# if ($changedFiles.getType().Name -eq 'String') {

#   $match = $changedFiles -match $extractionsFolder

#   if ($match){

#     $changedExtraction += $match
    
#     Write-Host 'The following extraction is changed:';
#     $match
#   }
# }

# # If multiple files have changed
# else {

#   ForEach ($changedFile in $changedFiles) {

#     $match = $changedFiles -match $extractionsFolder

#     if ($match){

#       $changedExtraction += $match
      
#       Write-Host 'The following extraction is changed:';
#       $match
#     }
#   }
# }
