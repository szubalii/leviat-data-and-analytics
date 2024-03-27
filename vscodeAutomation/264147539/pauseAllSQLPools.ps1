Connect-AzAccount -Identity

$resourceGroups = 'rg-xxxx-sls-p-euw-001';

ForEach ($resourceGroup in $resourceGroups) {

    $workspaces = Get-AzSynapseWorkspace -ResourceGroupName $resourceGroup;

    ForEach ($workspace in $workspaces) {

        $workspace
        $sqlPools = Get-AzSynapseSqlPool -WorkspaceName $workspace.Name;

        ForEach ($sqlPool in $sqlPools) {

            $sqlPool
            Suspend-AzSynapseSqlPool -WorkspaceName $workspace -Name $sqlPool.Name -Asjob
        }
    }
}
