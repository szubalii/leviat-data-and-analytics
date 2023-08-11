$filePaths = @(
'synapse-dwh/syndw_xxxx_sls_d_euw_001/dq/Views/vw_BP_2_0_4.sql',
'synapse-dwh/syndw_xxxx_sls_d_euw_001/dq/Views/vw_BP_2_0_5.sql',
'synapse-dwh/syndw_xxxx_sls_d_euw_001/dq/Views/vw_BP_2_0_8.sql',
'synapse-dwh/syndw_xxxx_sls_d_euw_001/dq/Views/vw_BP_2_0_9_ThirdParty.sql',
'synapse-dwh/syndw_xxxx_sls_d_euw_001/dq/Views/vw_BP_2_1_10.sql',
'synapse-dwh/syndw_xxxx_sls_d_euw_001/dq/Views/vw_BP_2_1_8.sql',
'synapse-dwh/syndw_xxxx_sls_d_euw_001/dq/Views/vw_BP_2_2_1_Intercompany.sql',
'synapse-dwh/syndw_xxxx_sls_d_euw_001/dq/Views/vw_BP_2_2_1_ThirdParty.sql',
'synapse-dwh/syndw_xxxx_sls_d_euw_001/dq/Views/vw_BP_2_2_2.sql',
'azure-data-factory/syndw_xxxx_sls_d_euw_001/dq/Views/vw_BP_2_2_2.sql'
)

$solutions = @('azure-data-factory', 'orchestration', 'synapse-dwh', 'synapse-workspace', 'xu-config')




ForEach ($solution in $solutions) {
  $solutionFolder = $solution+'/';
  Write-Host $solutionFolder
  Write-Host 'Checking solution:'$solution;

  $filePaths -match $solutionFolder
  
  if (($filePaths -match $solutionFolder).count -eq 0){
    Write-Host 'No changed files found for'$solution;
    $solutionVarName = 'deploy_'+$solution;
    Write-Host "##vso[task.setvariable variable=$solutionVarName;isoutput=true]false";
    #Write-Host 'variables.'$solutionVarName= $(solutionDeployment.$solutionVarName);
  }
}