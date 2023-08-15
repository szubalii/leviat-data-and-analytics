$solutions = @(
  ('azure-data-factory', 'DataFactoryARMTemplate'),
  ('orchestration', 'OrchestrationDB'),
  ('synapse-dwh', 'SynapseDWH'),
  ('synapse-workspace', 'SynapseWorkspace'),
  ('xu-config', 'XtractUniversal')
);

ForEach ($solutionTuple in $solutions) {
  $solutionName = $solutionTuple[0];
  $solutionArtifact = $solutionTuple[1];
  $solutionVarName = 'deploy_'+$solutionName.replace('-', '_');

  $path = $(Pipeline.WorkSpace)+'/build/'+$solutionArtifact;

  # Artifact name exists in pipeline workspace, so do deploy
  if (Test-Path -Path $path){
    Write-Host 'The following build was found:'$solutionArtifact;
    Write-Host 'Deployment of'$solutionName' will proceed.';
    Write-Host "##vso[task.setvariable variable=$solutionVarName;isOutput=true]true";
  }
  # Artifact name doens't exist in pipeline workspace, so don't deploy
  else {
    Write-Host 'No build found for'$solution'. Deployment of' $solution' will not take place.';
    Write-Host "##vso[task.setvariable variable=$solutionVarName;isOutput=true]false";
  }
  Write-Host "`n"  
}