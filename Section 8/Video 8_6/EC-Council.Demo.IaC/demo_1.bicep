
@allowed([
  'dev'
  'sbx'
  'uat'
  'prd'
])
param par_environment string

param par_storageName string

param par_location string = resourceGroup().location


module stor '../Shared.IaC.Templates/Common/IaC/Modules/Storage/StorageV2.bicep' = {
  name: par_storageName
  params: {
    environment: par_environment
    storageAccountName:  par_storageName
    storageAccountSku: 'Standard_LRS'
    storageAccountLocation: par_location
  }
}


