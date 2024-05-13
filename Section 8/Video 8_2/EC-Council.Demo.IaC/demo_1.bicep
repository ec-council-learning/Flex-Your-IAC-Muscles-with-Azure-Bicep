
@allowed([
  'dev'
  'sbx'
  'uat'
  'prd'
])
param par_environment string
param par_location string = resourceGroup().location

param par_storName string 


module stors '../Shared.IaC.Templates/Common/IaC/Modules/Storage/StorageV2.bicep' = if (par_environment == 'sbx') {

  name: par_storName
  params: {
    environment: par_environment 
    storageAccountName: par_storName
    storageAccountSku:  'Standard_LRS' 
      storageAccountLocation: par_location
  }
}


