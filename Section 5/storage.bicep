resource mystorage 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 'steccouncilstorlesson5'
  location: resourceGroup().location
  sku: {
    name:  'Standard_LRS'
  }
  kind:  'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
  }
}

