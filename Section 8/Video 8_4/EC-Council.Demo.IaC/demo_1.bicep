
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
    storageAccountSku: par_environment == 'dev' ? 'Standard_LRS' : par_environment == 'sbx' ? 'Standard_ZRS' : 'Standard_GZRS'
    storageAccountLocation: par_location
  }
}


