param name string = 'xxxx_sls'

var var_synapseSqlPool = {
  value: 'syndw_${name}_d_euw_001'
}

resource synapseSqlPool 'Microsoft.Synapse/workspaces/sqlPools@2021-06-01' = {
  name: 'ws_xxxx_sls_d_euw_001/${var_synapseSqlPool}'
  location: 'westeurope'
  tags: {
    area: 'Sales'
    compaycode: 'xxxx'
    environment: 'DEV'
    region: 'Europe West'
    createdby: 'Michiel Pors'
    createdon: '15-04-2021'
    FinID: '5300U01'
  }
  sku: {
    name: 'DW100c'
    capacity: 0
  }
  properties: {
    maxSizeBytes: 263882790666240
    collation: 'SQL_Latin1_General_CP1_CS_AS'
    storageAccountType: 'GRS'
    provisioningState: 'Succeeded'
  }
}

resource synapseSqlPool_Default 'Microsoft.Synapse/workspaces/sqlPools/auditingSettings@2021-06-01' = {
  parent: synapseSqlPool
  name: 'default'
  properties: {
    retentionDays: 0
    auditActionsAndGroups: []
    isStorageSecondaryKeyInUse: false
    isAzureMonitorTargetEnabled: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
}

resource Microsoft_Synapse_workspaces_sqlPools_extendedAuditingSettings_synapseSqlPool_Default 'Microsoft.Synapse/workspaces/sqlPools/extendedAuditingSettings@2021-06-01' = {
  parent: synapseSqlPool
  name: 'default'
  properties: {
    retentionDays: 0
    auditActionsAndGroups: []
    isStorageSecondaryKeyInUse: false
    isAzureMonitorTargetEnabled: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
}

resource Microsoft_Synapse_workspaces_sqlPools_geoBackupPolicies_synapseSqlPool_Default 'Microsoft.Synapse/workspaces/sqlPools/geoBackupPolicies@2021-06-01' = {
  parent: synapseSqlPool
  name: 'Default'
  location: 'West Europe'
  properties: {
    state: 'Enabled'
  }
}

resource Microsoft_Synapse_workspaces_sqlPools_securityAlertPolicies_synapseSqlPool_Default 'Microsoft.Synapse/workspaces/sqlPools/securityAlertPolicies@2021-06-01' = {
  parent: synapseSqlPool
  name: 'Default'
  properties: {
    state: 'Disabled'
    disabledAlerts: [
      ''
    ]
    emailAddresses: [
      ''
    ]
    emailAccountAdmins: false
    retentionDays: 0
  }
}

resource synapseSqlPool_current 'Microsoft.Synapse/workspaces/sqlPools/transparentDataEncryption@2021-06-01' = {
  parent: synapseSqlPool
  name: 'current'
  location: 'West Europe'
  properties: {
    status: 'Disabled'
  }
}

resource Microsoft_Synapse_workspaces_sqlPools_vulnerabilityAssessments_synapseSqlPool_Default 'Microsoft.Synapse/workspaces/sqlPools/vulnerabilityAssessments@2021-06-01' = {
  parent: synapseSqlPool
  name: 'Default'
  properties: {
    recurringScans: {
      isEnabled: false
      emailSubscriptionAdmins: true
    }
  }
}

resource synapseSqlPool_largerc 'Microsoft.Synapse/workspaces/sqlPools/workloadGroups@2021-06-01' = {
  parent: synapseSqlPool
  name: 'largerc'
  properties: {
    minResourcePercent: 0
    maxResourcePercent: 100
    minResourcePercentPerRequest: 22
    maxResourcePercentPerRequest: 22
    importance: 'normal'
    queryExecutionTimeout: 0
  }
}

resource synapseSqlPool_mediumrc 'Microsoft.Synapse/workspaces/sqlPools/workloadGroups@2021-06-01' = {
  parent: synapseSqlPool
  name: 'mediumrc'
  properties: {
    minResourcePercent: 0
    maxResourcePercent: 100
    minResourcePercentPerRequest: 10
    maxResourcePercentPerRequest: 10
    importance: 'normal'
    queryExecutionTimeout: 0
  }
}

resource synapseSqlPool_smallrc 'Microsoft.Synapse/workspaces/sqlPools/workloadGroups@2021-06-01' = {
  parent: synapseSqlPool
  name: 'smallrc'
  properties: {
    minResourcePercent: 0
    maxResourcePercent: 100
    minResourcePercentPerRequest: 3
    maxResourcePercentPerRequest: 3
    importance: 'normal'
    queryExecutionTimeout: 0
  }
}

resource synapseSqlPool_staticrc10 'Microsoft.Synapse/workspaces/sqlPools/workloadGroups@2021-06-01' = {
  parent: synapseSqlPool
  name: 'staticrc10'
  properties: {
    minResourcePercent: 0
    maxResourcePercent: 100
    minResourcePercentPerRequest: '0.4'
    maxResourcePercentPerRequest: '0.4'
    importance: 'normal'
    queryExecutionTimeout: 0
  }
}

resource synapseSqlPool_staticrc20 'Microsoft.Synapse/workspaces/sqlPools/workloadGroups@2021-06-01' = {
  parent: synapseSqlPool
  name: 'staticrc20'
  properties: {
    minResourcePercent: 0
    maxResourcePercent: 100
    minResourcePercentPerRequest: '0.8'
    maxResourcePercentPerRequest: '0.8'
    importance: 'normal'
    queryExecutionTimeout: 0
  }
}

resource synapseSqlPool_staticrc30 'Microsoft.Synapse/workspaces/sqlPools/workloadGroups@2021-06-01' = {
  parent: synapseSqlPool
  name: 'staticrc30'
  properties: {
    minResourcePercent: 0
    maxResourcePercent: 100
    minResourcePercentPerRequest: '1.6'
    maxResourcePercentPerRequest: '1.6'
    importance: 'normal'
    queryExecutionTimeout: 0
  }
}

resource synapseSqlPool_staticrc40 'Microsoft.Synapse/workspaces/sqlPools/workloadGroups@2021-06-01' = {
  parent: synapseSqlPool
  name: 'staticrc40'
  properties: {
    minResourcePercent: 0
    maxResourcePercent: 100
    minResourcePercentPerRequest: '3.2'
    maxResourcePercentPerRequest: '3.2'
    importance: 'normal'
    queryExecutionTimeout: 0
  }
}

resource synapseSqlPool_staticrc50 'Microsoft.Synapse/workspaces/sqlPools/workloadGroups@2021-06-01' = {
  parent: synapseSqlPool
  name: 'staticrc50'
  properties: {
    minResourcePercent: 0
    maxResourcePercent: 100
    minResourcePercentPerRequest: '6.4'
    maxResourcePercentPerRequest: '6.4'
    importance: 'normal'
    queryExecutionTimeout: 0
  }
}

resource synapseSqlPool_staticrc60 'Microsoft.Synapse/workspaces/sqlPools/workloadGroups@2021-06-01' = {
  parent: synapseSqlPool
  name: 'staticrc60'
  properties: {
    minResourcePercent: 0
    maxResourcePercent: 100
    minResourcePercentPerRequest: '12.8'
    maxResourcePercentPerRequest: '12.8'
    importance: 'normal'
    queryExecutionTimeout: 0
  }
}

resource synapseSqlPool_staticrc70 'Microsoft.Synapse/workspaces/sqlPools/workloadGroups@2021-06-01' = {
  parent: synapseSqlPool
  name: 'staticrc70'
  properties: {
    minResourcePercent: 0
    maxResourcePercent: 100
    minResourcePercentPerRequest: '25.6'
    maxResourcePercentPerRequest: '25.6'
    importance: 'normal'
    queryExecutionTimeout: 0
  }
}

resource synapseSqlPool_staticrc80 'Microsoft.Synapse/workspaces/sqlPools/workloadGroups@2021-06-01' = {
  parent: synapseSqlPool
  name: 'staticrc80'
  properties: {
    minResourcePercent: 0
    maxResourcePercent: 100
    minResourcePercentPerRequest: '51.2'
    maxResourcePercentPerRequest: '51.2'
    importance: 'normal'
    queryExecutionTimeout: 0
  }
}

resource synapseSqlPool_xlargerc 'Microsoft.Synapse/workspaces/sqlPools/workloadGroups@2021-06-01' = {
  parent: synapseSqlPool
  name: 'xlargerc'
  properties: {
    minResourcePercent: 0
    maxResourcePercent: 100
    minResourcePercentPerRequest: 70
    maxResourcePercentPerRequest: 70
    importance: 'normal'
    queryExecutionTimeout: 0
  }
}

resource synapseSqlPool_largerc_largerc 'Microsoft.Synapse/workspaces/sqlPools/workloadGroups/workloadClassifiers@2021-06-01' = {
  parent: synapseSqlPool_largerc
  name: 'largerc'
  properties: {
    memberName: 'largerc'
    importance: 'normal'
  }
  dependsOn: [

    synapseSqlPool
  ]
}

resource synapseSqlPool_mediumrc_mediumrc 'Microsoft.Synapse/workspaces/sqlPools/workloadGroups/workloadClassifiers@2021-06-01' = {
  parent: synapseSqlPool_mediumrc
  name: 'mediumrc'
  properties: {
    memberName: 'mediumrc'
    importance: 'normal'
  }
  dependsOn: [

    synapseSqlPool
  ]
}

resource synapseSqlPool_smallrc_smallrc 'Microsoft.Synapse/workspaces/sqlPools/workloadGroups/workloadClassifiers@2021-06-01' = {
  parent: synapseSqlPool_smallrc
  name: 'smallrc'
  properties: {
    memberName: 'smallrc'
    importance: 'normal'
  }
  dependsOn: [

    synapseSqlPool
  ]
}

resource synapseSqlPool_staticrc10_staticrc10 'Microsoft.Synapse/workspaces/sqlPools/workloadGroups/workloadClassifiers@2021-06-01' = {
  parent: synapseSqlPool_staticrc10
  name: 'staticrc10'
  properties: {
    memberName: 'staticrc10'
    importance: 'normal'
  }
  dependsOn: [

    synapseSqlPool
  ]
}

resource synapseSqlPool_staticrc20_staticrc20 'Microsoft.Synapse/workspaces/sqlPools/workloadGroups/workloadClassifiers@2021-06-01' = {
  parent: synapseSqlPool_staticrc20
  name: 'staticrc20'
  properties: {
    memberName: 'staticrc20'
    importance: 'normal'
  }
  dependsOn: [

    synapseSqlPool
  ]
}

resource synapseSqlPool_staticrc30_staticrc30 'Microsoft.Synapse/workspaces/sqlPools/workloadGroups/workloadClassifiers@2021-06-01' = {
  parent: synapseSqlPool_staticrc30
  name: 'staticrc30'
  properties: {
    memberName: 'staticrc30'
    importance: 'normal'
  }
  dependsOn: [

    synapseSqlPool
  ]
}

resource synapseSqlPool_staticrc40_staticrc40 'Microsoft.Synapse/workspaces/sqlPools/workloadGroups/workloadClassifiers@2021-06-01' = {
  parent: synapseSqlPool_staticrc40
  name: 'staticrc40'
  properties: {
    memberName: 'staticrc40'
    importance: 'normal'
  }
  dependsOn: [

    synapseSqlPool
  ]
}

resource synapseSqlPool_staticrc50_staticrc50 'Microsoft.Synapse/workspaces/sqlPools/workloadGroups/workloadClassifiers@2021-06-01' = {
  parent: synapseSqlPool_staticrc50
  name: 'staticrc50'
  properties: {
    memberName: 'staticrc50'
    importance: 'normal'
  }
  dependsOn: [

    synapseSqlPool
  ]
}

resource synapseSqlPool_staticrc60_staticrc60 'Microsoft.Synapse/workspaces/sqlPools/workloadGroups/workloadClassifiers@2021-06-01' = {
  parent: synapseSqlPool_staticrc60
  name: 'staticrc60'
  properties: {
    memberName: 'staticrc60'
    importance: 'normal'
  }
  dependsOn: [

    synapseSqlPool
  ]
}

resource synapseSqlPool_staticrc70_staticrc70 'Microsoft.Synapse/workspaces/sqlPools/workloadGroups/workloadClassifiers@2021-06-01' = {
  parent: synapseSqlPool_staticrc70
  name: 'staticrc70'
  properties: {
    memberName: 'staticrc70'
    importance: 'normal'
  }
  dependsOn: [

    synapseSqlPool
  ]
}

resource synapseSqlPool_staticrc80_staticrc80 'Microsoft.Synapse/workspaces/sqlPools/workloadGroups/workloadClassifiers@2021-06-01' = {
  parent: synapseSqlPool_staticrc80
  name: 'staticrc80'
  properties: {
    memberName: 'staticrc80'
    importance: 'normal'
  }
  dependsOn: [

    synapseSqlPool
  ]
}

resource synapseSqlPool_xlargerc_xlargerc 'Microsoft.Synapse/workspaces/sqlPools/workloadGroups/workloadClassifiers@2021-06-01' = {
  parent: synapseSqlPool_xlargerc
  name: 'xlargerc'
  properties: {
    memberName: 'xlargerc'
    importance: 'normal'
  }
  dependsOn: [

    synapseSqlPool
  ]
}

// TODO: add personal adf as contributor to synapse workspace, so it can pause its corresponding sql pool
