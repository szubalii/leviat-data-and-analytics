# Check which solution artifacts are available in the build
# If a solution artifact is available, deploy it
# If a solution artifact is not available, do not deploy it
param (
  [string]$workspace
)

# Array of solution folder names tupled with their respective artifact name
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

  # The path includes the named pipeline resource
  $path = $workspace+'/build/'+$solutionArtifact;

  Write-Host $path;

  # Artifact name exists in pipeline workspace, so do deploy
  if (Test-Path -Path $path){
    Write-Host 'The following build was found:'$solutionArtifact;
    Write-Host 'Deployment of'$solutionName' will proceed.';
    Write-Host "##vso[task.setvariable variable=$solutionVarName;isOutput=true]true";
  }
  # Artifact name doens't exist in pipeline workspace, so don't deploy
  else {
    Write-Host 'No build found for'$solutionName'. Deployment of' $solutionName' will not take place.';
    Write-Host "##vso[task.setvariable variable=$solutionVarName;isOutput=true]false";
  }
  Write-Host "`n"  
}