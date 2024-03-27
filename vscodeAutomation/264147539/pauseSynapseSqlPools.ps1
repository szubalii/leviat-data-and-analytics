param(
  [string]$resourceGroup
)

Connect-AzAccount -Identity

# $resourceGroups = 'rg-xxxx-sls-p-euw-001';

# ForEach ($resourceGroup in $resourceGroups) {

    $workspaces = Get-AzSynapseWorkspace -ResourceGroupName $resourceGroup;

    ForEach ($workspace in $workspaces) {

        $sqlPools = Get-AzSynapseSqlPool -WorkspaceName $workspace.Name;

        ForEach ($sqlPool in $sqlPools) {

            Suspend-AzSynapseSqlPool -WorkspaceName $workspace -Name $sqlPool.Name -Asjob
        }
    }
# }
