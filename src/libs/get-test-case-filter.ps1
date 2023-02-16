Write-Host "$(System.DefaultWorkingDirectory)"
$filePaths = $(git diff-tree --no-commit-id --name-only -r $(Build.SourceVersion))
Write-Host "$($filePaths)"

$testCaseFilter = ""
ForEach ($filePath in $filePaths) {

    $dir = "syndw_xxxx_sls_d_euw_001"
    $dirIndex = $filePath.IndexOf($dir)
    $fileTypeIndex = $filePath.IndexOf(".")
    $filePathWithoutExt = $filePath.SubString(0, $fileTypeIndex)

    if ($dirIndex -ne -1) {
        $subFilePath = $filePathWithoutExt.SubString($dirIndex + $dir.Length)
        $className = $subFilePath.Replace('/','.')
        $testCaseFilter += "ClassName=Test.$className|"
    }

#TODO filter on list of files for only sql files
}
$testCaseFilter = $testCaseFilter.SubString(0, $testCaseFilter.Length-1)
Write-Host "$($testCaseFilter)"

Write-Host "##vso[task.setvariable variable=testCaseFilter]$testCaseFilter"

# $AzureDevOpsPAT = "$(ReadTestManagementPAT)"
# $AzureDevOpsAuthenicationHeader = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($AzureDevOpsPAT)")) }
# $uri = "https://dev.azure.com/leviatazure/Leviat_Data_and_Analytics_DevOps/_apis/testplan/Plans/${{parameters.testPlan}}/suites?api-version=7.0"
    
# Invoke-RestMethod -Uri $uri -Method get -Headers $AzureDevOpsAuthenicationHeader | ConvertTo-Json