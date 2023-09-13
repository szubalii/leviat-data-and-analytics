param (
  [string[]]$extractions
)

ForEach ($extraction in $extractions) {
  $extractionName = $env:SYSTEM_PULLREQUEST_PULLREQUESTID + '_' + $extraction
  $params = '-s localhost -p 8065 -n '+$extractionName
  $Command = "C:\'Program Files'\XtractUniversal\xu.exe"
  Invoke-Expression -Command "$Command $params"
}

