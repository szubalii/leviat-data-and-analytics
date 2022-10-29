param storageAccountName string
param containerNames array = [
  'adf-jobs'
  'ancon-australia-2-dwh-uat'
  'ancon-uk-files'
  'c4c'
  'dw-halfen-0-hlp-uat'
  'dw-halfen-1-stg-uat'
  'dw-halfen-2-dwh-uat'
  'flat-files'
  'isedio-files'
  'leviat-db-us'
  'orch-db'
  's4h-caa-200'
  'tx-ca-0-hlp-uat'
  'tx-crh-1-stg-uat'
  'tx-crh-2-dwh-uat'
  'tx-halfen-2-dwh-uat'
  'utilities'
  'xu-configuration'
]

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-05-01' existing = {
  name: storageAccountName
}

resource storageAccountBlob 'Microsoft.Storage/storageAccounts/blobServices@2022-05-01' existing = {
  parent: storageAccount
  name: 'default'
}

resource storageAccountContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = [for containerName in containerNames: {
  parent: storageAccountBlob
  name: containerName
  properties: {
    // immutableStorageWithVersioning: {
    //   enabled: false
    // }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
}]

// resource storageAccount_default_ancon_australia_2_dwh 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = {
//   name: 'ancon-australia-2-dwh'
//   properties: {
//     immutableStorageWithVersioning: {
//       enabled: false
//     }
//     defaultEncryptionScope: '$account-encryption-key'
//     denyEncryptionScopeOverride: false
//     publicAccess: 'None'
//   }
// }

// resource storageAccount_default_ancon_uk_files 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = {
//   name: 'ancon-uk-files'
//   properties: {
//     immutableStorageWithVersioning: {
//       enabled: false
//     }
//     defaultEncryptionScope: '$account-encryption-key'
//     denyEncryptionScopeOverride: false
//     publicAccess: 'None'
//   }
// }

// resource storageAccount_default_azure_webjobs_hosts 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = {
//   name: 'azure-webjobs-hosts'
//   properties: {
//     immutableStorageWithVersioning: {
//       enabled: false
//     }
//     defaultEncryptionScope: '$account-encryption-key'
//     denyEncryptionScopeOverride: false
//     publicAccess: 'None'
//   }
// }

// resource storageAccount_default_azure_webjobs_secrets 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = {
//   name: 'azure-webjobs-secrets'
//   properties: {
//     immutableStorageWithVersioning: {
//       enabled: false
//     }
//     defaultEncryptionScope: '$account-encryption-key'
//     denyEncryptionScopeOverride: false
//     publicAccess: 'None'
//   }
// }

// resource storageAccount_default_c4c 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = {
//   name: 'c4c'
//   properties: {
//     immutableStorageWithVersioning: {
//       enabled: false
//     }
//     defaultEncryptionScope: '$account-encryption-key'
//     denyEncryptionScopeOverride: false
//     publicAccess: 'None'
//   }
// }

// resource storageAccount_default_dw_halfen_0_hlp_uat 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = {
//   name: 'dw-halfen-0-hlp-uat'
//   properties: {
//     immutableStorageWithVersioning: {
//       enabled: false
//     }
//     defaultEncryptionScope: '$account-encryption-key'
//     denyEncryptionScopeOverride: false
//     publicAccess: 'None'
//   }
// }

// resource storageAccount_default_dw_halfen_1_stg_uat 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = {
//   name: 'dw-halfen-1-stg-uat'
//   properties: {
//     immutableStorageWithVersioning: {
//       enabled: false
//     }
//     defaultEncryptionScope: '$account-encryption-key'
//     denyEncryptionScopeOverride: false
//     publicAccess: 'None'
//   }
// }

// resource storageAccount_default_dw_halfen_2_dwh_uat 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = {
//   name: 'dw-halfen-2-dwh-uat'
//   properties: {
//     immutableStorageWithVersioning: {
//       enabled: false
//     }
//     defaultEncryptionScope: '$account-encryption-key'
//     denyEncryptionScopeOverride: false
//     publicAccess: 'None'
//   }
// }

// resource storageAccount_default_flat_files 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = {
//   name: 'flat-files'
//   properties: {
//     immutableStorageWithVersioning: {
//       enabled: false
//     }
//     defaultEncryptionScope: '$account-encryption-key'
//     denyEncryptionScopeOverride: false
//     publicAccess: 'None'
//   }
// }

// resource storageAccount_default_isedio_files 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = {
//   name: 'isedio-files'
//   properties: {
//     immutableStorageWithVersioning: {
//       enabled: false
//     }
//     defaultEncryptionScope: '$account-encryption-key'
//     denyEncryptionScopeOverride: false
//     publicAccess: 'None'
//   }
// }

// resource storageAccount_default_leviat_db_us 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = {
//   name: 'leviat-db-us'
//   properties: {
//     immutableStorageWithVersioning: {
//       enabled: false
//     }
//     defaultEncryptionScope: '$account-encryption-key'
//     denyEncryptionScopeOverride: false
//     publicAccess: 'None'
//   }
// }

// resource storageAccount_default_orch_db 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = {
//   name: 'orch-db'
//   properties: {
//     immutableStorageWithVersioning: {
//       enabled: false
//     }
//     defaultEncryptionScope: '$account-encryption-key'
//     denyEncryptionScopeOverride: false
//     publicAccess: 'None'
//   }
// }

// resource storageAccount_default_s4h_caa_200 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = {
//   name: 's4h-caa-200'
//   properties: {
//     immutableStorageWithVersioning: {
//       enabled: false
//     }
//     defaultEncryptionScope: '$account-encryption-key'
//     denyEncryptionScopeOverride: false
//     publicAccess: 'None'
//   }
// }

// resource storageAccount_default_s4h_caa_500 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = {
//   name: 's4h-caa-500'
//   properties: {
//     immutableStorageWithVersioning: {
//       enabled: false
//     }
//     defaultEncryptionScope: '$account-encryption-key'
//     denyEncryptionScopeOverride: false
//     publicAccess: 'None'
//   }
// }

// resource storageAccount_default_s4h_cad_200 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = {
//   name: 's4h-cad-200'
//   properties: {
//     immutableStorageWithVersioning: {
//       enabled: false
//     }
//     defaultEncryptionScope: '$account-encryption-key'
//     denyEncryptionScopeOverride: false
//     publicAccess: 'None'
//   }
// }

// resource storageAccount_default_tx_ca_0_hlp_uat 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = {
//   name: 'tx-ca-0-hlp-uat'
//   properties: {
//     immutableStorageWithVersioning: {
//       enabled: false
//     }
//     defaultEncryptionScope: '$account-encryption-key'
//     denyEncryptionScopeOverride: false
//     publicAccess: 'None'
//   }
// }

// resource storageAccount_default_tx_crh_1_stg_uat 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = {
//   name: 'tx-crh-1-stg'
//   properties: {
//     immutableStorageWithVersioning: {
//       enabled: false
//     }
//     defaultEncryptionScope: '$account-encryption-key'
//     denyEncryptionScopeOverride: false
//     publicAccess: 'None'
//   }
// }

// resource storageAccount_default_tx_crh_2_dwh_uat 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = {
//   name: 'tx-crh-2-dwh-uat'
//   properties: {
//     immutableStorageWithVersioning: {
//       enabled: false
//     }
//     defaultEncryptionScope: '$account-encryption-key'
//     denyEncryptionScopeOverride: false
//     publicAccess: 'None'
//   }
// }

// resource storageAccount_default_tx_halfen_2_dwh_uat 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = {
//   name: 'tx-halfen-2-dwh-uat'
//   properties: {
//     immutableStorageWithVersioning: {
//       enabled: false
//     }
//     defaultEncryptionScope: '$account-encryption-key'
//     denyEncryptionScopeOverride: false
//     publicAccess: 'None'
//   }
// }

// resource storageAccount_default_utilities 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = {
//   name: 'utilities'
//   properties: {
//     immutableStorageWithVersioning: {
//       enabled: false
//     }
//     defaultEncryptionScope: '$account-encryption-key'
//     denyEncryptionScopeOverride: false
//     publicAccess: 'None'
//   }
// }

// resource storageAccount_default_xu_configuration 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = {
//   name: 'xu-configuration'
//   properties: {
//     immutableStorageWithVersioning: {
//       enabled: false
//     }
//     defaultEncryptionScope: '$account-encryption-key'
//     denyEncryptionScopeOverride: false
//     publicAccess: 'None'
//   }
// }
