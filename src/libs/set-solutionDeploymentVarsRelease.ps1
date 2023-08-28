param (
  [string]$commitId#,
  # [string]$commitMessage
)

# $changedFiles = @(
# 'synapse-dwh/syndw_xxxx_sls_d_euw_001/dq/Views/vw_BP_2_2_1_ThirdParty.sql',
# 'synapse-dwh/syndw_xxxx_sls_d_euw_001/dq/Views/vw_BP_2_2_2.sql',
# 'azure-data-factory/syndw_xxxx_sls_d_euw_001/dq/Views/vw_BP_2_2_2.sql'
# );
$solutions = @('azure-data-factory', 'orchestration', 'synapse-dwh', 'synapse-workspace', 'xu-config');

# Retrieve list of changed files
# Write-Host "System.DefaultWorkingDirectory: $(System.DefaultWorkingDirectory)"
Write-Host "CommitID:"$commitId
# Write-Host "Build.SourceVersion: $(Build.SourceVersion)"
# Write-Host "Build.SourceVersionMessage: $commitMessage`n"
$changedFiles = git diff --name-only $commitId^! #difference between parent of commit and commit
# $changedFiles2 = $(git diff-tree --no-commit-id --name-only -r $(Build.SourceVersion))
Write-Host "The following files have changed:"
$changedFiles
Write-Host "`n"

ForEach ($solution in $solutions) {
  $solutionFolder = $solution+'/';
  $solutionVarName = 'deploy_'+$solution.replace('-', '_');
  Write-Host 'Check if there are any changed files for folder '$solutionFolder':';

  # If a single file has changed
  if ($changedFiles.getType().Name -eq 'String') {
    # Changed file matches selected solution, so do deploy
    if ($changedFiles -match $solutionFolder){
      Write-Host 'The following files were changed:';
      $changedFiles -match $solutionFolder
      Write-Host 'Deployment of'$solution' will proceed.';
      Write-Host "##vso[task.setvariable variable=$solutionVarName;isOutput=true]true";
    }
    # Changed file doesn't match solution, so don't deploy
    else {
      Write-Host 'No changed files found for'$solution'. Deployment of' $solution' will not take place.';
      Write-Host "##vso[task.setvariable variable=$solutionVarName;isOutput=true]false";
    }
    Write-Host "`n"
  }

  # If multiple files have changed            
  else {
    # No changed files match selected solution, so don't deploy
    if (($changedFiles -match $solutionFolder).count -eq 0){
      Write-Host 'No changed files found for'$solution'. Deployment of' $solution' will not take place.';
      Write-Host "##vso[task.setvariable variable=$solutionVarName;isOutput=true]false";
    }
    # Changed files match solution, so do deploy
    else {
      Write-Host 'The following files were changed:';
      $changedFiles -match $solutionFolder
      Write-Host 'Deployment of'$solution' will proceed.';
      Write-Host "##vso[task.setvariable variable=$solutionVarName;isOutput=true]true";
    }
    Write-Host "`n"
  }
}