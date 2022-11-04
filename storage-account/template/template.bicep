param name string = 'xxxxsls'
// param containerNames array = [
//   'adf-jobs'
//   'ancon-australia-2-dwh-uat'
//   'ancon-uk-files'
//   'c4c'
//   'dw-halfen-0-hlp-uat'
//   'dw-halfen-1-stg-uat'
//   'dw-halfen-2-dwh-uat'
//   'flat-files'
//   'isedio-files'
//   'leviat-db-us'
//   'orch-db'
//   's4h-caa-200'
//   'tx-ca-0-hlp-uat'
//   'tx-crh-1-stg-uat'
//   'tx-crh-2-dwh-uat'
//   'tx-halfen-2-dwh-uat'
//   'utilities'
//   'xu-configuration'
// ]

var var_storageAccount = 'st${name}deuw001'

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: var_storageAccount
  location: 'westeurope'
  tags: {
    environment: 'DEV'
    createdby: 'Ralf Slofstra'
    createdon: '14-04-2021'
    compaycode: 'xxxx'
    region: 'Europe West'
    FinID: '5300U01'
  }
  sku: {
    name: 'Standard_RAGRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    defaultToOAuthAuthentication: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    isHnsEnabled: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource Microsoft_Storage_storageAccounts_blobServices_storageAccount_default 'Microsoft.Storage/storageAccounts/blobServices@2022-05-01' = {
  parent: storageAccount
  name: 'default'
  sku: {
    name: 'Standard_RAGRS'
    tier: 'Standard'
  }
  properties: {
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: false
    }
  }
}

// File Services results in failed deployment:
// "error": {
//   "code": "InvalidXmlDocument",
//   "message": "XML specified is not syntactically valid.\nRequestId:cd7d79cd-f01a-0015-38cb-ea83c1000000\nTime:2022-10-28T12:48:05.7783719Z"
// }
// resource Microsoft_Storage_storageAccounts_fileServices_storageAccount_default 'Microsoft.Storage/storageAccounts/fileServices@2022-05-01' = {
//   parent: storageAccount
//   name: 'default'
//   sku: {
//     name: 'Standard_RAGRS'
//     tier: 'Standard'
//   }
//   properties: {
//     protocolSettings: {
//       smb: {
//       }
//     }
//     cors: {
//       corsRules: []
//     }
//     shareDeleteRetentionPolicy: {
//       enabled: true
//       days: 7
//     }
//   }
// }

resource Microsoft_Storage_storageAccounts_queueServices_storageAccount_default 'Microsoft.Storage/storageAccounts/queueServices@2022-05-01' = {
  parent: storageAccount
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccount_default 'Microsoft.Storage/storageAccounts/tableServices@2022-05-01' = {
  parent: storageAccount
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

// @batchSize(int)
module storageAccountContainer 'container.bicep' = {
  name: 'storageAccountContainers'
  params: {
    storageAccountName: var_storageAccount
  }
  dependsOn: [
    Microsoft_Storage_storageAccounts_blobServices_storageAccount_default
  ]
}
