
@allowed([
  'dev'
  'sbx'
  'uat'
  'prd'
])
param par_environment string
param par_location string = resourceGroup().location

param par_storAccounts array


  module stors '../Shared.IaC.Templates/Common/IaC/Modules/Storage/StorageV2.bicep' = [ for item in par_storAccounts: {

    name: '${item}'
    params: {
      environment: par_environment 
      storageAccountName: item  
      storageAccountSku:  'Standard_LRS' 
      storageAccountLocation: par_location
    }
  }]


