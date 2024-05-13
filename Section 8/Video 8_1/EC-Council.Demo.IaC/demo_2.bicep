
@allowed([
  'dev'
  'sbx'
  'uat'
  'prd'
])
param par_environment string
param par_location string = resourceGroup().location

param par_storItems int


  module stors '../Shared.IaC.Templates/Common/IaC/Modules/Storage/StorageV2.bicep' = [for i in range(1,par_storItems) :{

    name: '${i}stordeploy'
    params: {
      environment: par_environment 
      storageAccountName: padLeft(i,3,'0')
      storageAccountSku:  'Standard_LRS' 
       storageAccountLocation: par_location
    }
  }]


