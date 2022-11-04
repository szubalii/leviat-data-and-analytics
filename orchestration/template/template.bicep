param name string = 'xxxx-sls'

var var_sqlDatabase = 'sqldb-${name}-d-euw-001'

resource sqlDatabase 'Microsoft.Sql/servers/databases@2022-02-01-preview' = {
  name: 'sqlsrv_xxxx_sls_d_euw_001/${var_sqlDatabase}'
  location: 'westeurope'
  tags: {
    compaycode: 'xxxx'
    createdby: 'Ralf Slofstra'
    createdon: '06-08-2021'
    environment: 'DEV'
    region: 'Europe West'
    FinID: '5300U01'
  }
  sku: {
    name: 'GP_S_Gen5'
    tier: 'GeneralPurpose'
    family: 'Gen5'
    capacity: 2
  }
  kind: 'v12.0,user,vcore,serverless'
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    maxSizeBytes: 53687091200
    catalogCollation: 'SQL_Latin1_General_CP1_CI_AS'
    zoneRedundant: false
    readScale: 'Disabled'
    autoPauseDelay: 60
    requestedBackupStorageRedundancy: 'Geo'
    minCapacity: '0.5'
    maintenanceConfigurationId: '/subscriptions/f199b488-7d9d-4992-aeda-c10a1e1c9b9e/providers/Microsoft.Maintenance/publicMaintenanceConfigurations/SQL_Default'
    isLedgerOn: false
  }
}

resource sqlDatabase_Default 'Microsoft.Sql/servers/databases/advancedThreatProtectionSettings@2022-02-01-preview' = {
  name: 'sqlsrv_xxxx_sls_d_euw_001/${var_sqlDatabase}/Default'
  properties: {
    state: 'Disabled'
  }
  dependsOn: [
    sqlDatabase
  ]
}

resource Microsoft_Sql_servers_databases_auditingPolicies_sqlDatabase_Default 'Microsoft.Sql/servers/databases/auditingPolicies@2014-04-01' = {
  name: 'sqlsrv_xxxx_sls_d_euw_001/${var_sqlDatabase}/Default'
  location: 'West Europe'
  properties: {
    auditingState: 'Disabled'
  }
  dependsOn: [
    sqlDatabase
  ]
}

resource Microsoft_Sql_servers_databases_auditingSettings_sqlDatabase_Default 'Microsoft.Sql/servers/databases/auditingSettings@2022-02-01-preview' = {
  name: 'sqlsrv_xxxx_sls_d_euw_001/${var_sqlDatabase}/Default'
  properties: {
    retentionDays: 0
    auditActionsAndGroups: []
    isStorageSecondaryKeyInUse: false
    isAzureMonitorTargetEnabled: false
    isManagedIdentityInUse: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
  dependsOn: [
    sqlDatabase
  ]
}

resource Microsoft_Sql_servers_databases_backupLongTermRetentionPolicies_sqlDatabase_default 'Microsoft.Sql/servers/databases/backupLongTermRetentionPolicies@2022-02-01-preview' = {
  name: 'sqlsrv_xxxx_sls_d_euw_001/${var_sqlDatabase}/default'
  properties: {
    weeklyRetention: 'PT0S'
    monthlyRetention: 'PT0S'
    yearlyRetention: 'PT0S'
    weekOfYear: 0
  }
  dependsOn: [
    sqlDatabase
  ]
}

resource Microsoft_Sql_servers_databases_backupShortTermRetentionPolicies_sqlDatabase_default 'Microsoft.Sql/servers/databases/backupShortTermRetentionPolicies@2022-02-01-preview' = {
  name: 'sqlsrv_xxxx_sls_d_euw_001/${var_sqlDatabase}/default'
  properties: {
    retentionDays: 7
    diffBackupIntervalInHours: 12
  }
  dependsOn: [
    sqlDatabase
  ]
}

resource Microsoft_Sql_servers_databases_extendedAuditingSettings_sqlDatabase_Default 'Microsoft.Sql/servers/databases/extendedAuditingSettings@2022-02-01-preview' = {
  name: 'sqlsrv_xxxx_sls_d_euw_001/${var_sqlDatabase}/Default'
  properties: {
    retentionDays: 0
    auditActionsAndGroups: []
    isStorageSecondaryKeyInUse: false
    isAzureMonitorTargetEnabled: false
    isManagedIdentityInUse: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
  dependsOn: [
    sqlDatabase
  ]
}

resource Microsoft_Sql_servers_databases_geoBackupPolicies_sqlDatabase_Default 'Microsoft.Sql/servers/databases/geoBackupPolicies@2014-04-01' = {
  name: 'sqlsrv_xxxx_sls_d_euw_001/${var_sqlDatabase}/Default'
  location: 'West Europe'
  properties: {
    state: 'Enabled'
  }
  dependsOn: [
    sqlDatabase
  ]
}

resource sqlDatabase_Current 'Microsoft.Sql/servers/databases/ledgerDigestUploads@2022-02-01-preview' = {
  name: 'sqlsrv_xxxx_sls_d_euw_001/${var_sqlDatabase}/Current'
  properties: {
  }
  dependsOn: [
    sqlDatabase
  ]
}

resource Microsoft_Sql_servers_databases_securityAlertPolicies_sqlDatabase_Default 'Microsoft.Sql/servers/databases/securityAlertPolicies@2022-02-01-preview' = {
  name: 'sqlsrv_xxxx_sls_d_euw_001/${var_sqlDatabase}/Default'
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
  dependsOn: [
    sqlDatabase
  ]
}

resource Microsoft_Sql_servers_databases_transparentDataEncryption_sqlDatabase_Current 'Microsoft.Sql/servers/databases/transparentDataEncryption@2022-02-01-preview' = {
  name: 'sqlsrv_xxxx_sls_d_euw_001/${var_sqlDatabase}/Current'
  properties: {
    state: 'Enabled'
  }
  dependsOn: [
    sqlDatabase
  ]
}

resource Microsoft_Sql_servers_databases_vulnerabilityAssessments_sqlDatabase_Default 'Microsoft.Sql/servers/databases/vulnerabilityAssessments@2022-02-01-preview' = {
  name: 'sqlsrv_xxxx_sls_d_euw_001/${var_sqlDatabase}/Default'
  properties: {
    recurringScans: {
      isEnabled: false
      emailSubscriptionAdmins: true
      emails: []
    }
  }
  dependsOn: [
    sqlDatabase
  ]
}
