




@allowed([
  'dev'
  'sbx'
  'uat'
  'prd'
])
param par_environment string

param par_storageName string

param par_location string = resourceGroup().location

param par_kvName string


// Create the storage account
module stor '../Shared.IaC.Templates/Common/IaC/Modules/Storage/StorageV2.bicep' = {
  name: par_storageName
  params: {
    environment: par_environment
    storageAccountName:  par_storageName
    storageAccountSku: 'Standard_LRS'
    storageAccountLocation: par_location
  }
}


// Add the storeage account connection string to Key Vaut
module kv '../Shared.IaC.Templates/Common/IaC/Modules/Security/AddKeyVaultValue.bicep' = {
  name: par_kvName
  params: {
    KeyVaultName: par_kvName
    secretName: '${stor.outputs.storageAccountName}-conn-${par_environment}'
    secretValue: stor.outputs.storageAccountConnStr
  }
  dependsOn:[
    stor
  ]
}

