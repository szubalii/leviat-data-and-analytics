param (
  [string[]]$extractions
  [string]$xuPrefix
)

ForEach ($extraction in $extractions) {
  $extractionName = $xuPrefix + '_' + $extraction
  $params = '-s localhost -p 8065 -n '+$extractionName
  $Command = "C:\'Program Files'\XtractUniversal\xu.exe"
  Invoke-Expression -Command "$Command $params"
}

