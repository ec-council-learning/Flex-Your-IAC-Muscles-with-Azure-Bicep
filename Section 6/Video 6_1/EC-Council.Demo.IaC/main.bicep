
@allowed([
  'dev'
  'sbx'
  'uat'
  'prd'
])
param par_environment string

param par_storName1 string 

param par_storName2 string

@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_ZRS'
])
param par_storageSku string

param par_location string = resourceGroup().location

module stor1 '../Shared.IaC.Templates/Common/IaC/Modules/Storage/StorageV2.bicep' = {
  name: par_storName1
  params: {
    environment: par_environment
    storageAccountName:  par_storName1
    storageAccountSku: par_storageSku
    storageAccountLocation: par_location
  }
}

module stor2 '../Shared.IaC.Templates/Common/IaC/Modules/Storage/StorageV2.bicep' = {
  name: par_storName2
  params: {
    environment: par_environment
    storageAccountName:  par_storName2
    storageAccountSku: par_storageSku
    storageAccountLocation: par_location
  }
}
