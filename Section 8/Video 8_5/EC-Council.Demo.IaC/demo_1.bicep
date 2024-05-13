
@allowed([
  'dev'
  'sbx'
  'uat'
  'prd'
])
param par_environment string

param par_storageName string

param par_location string = resourceGroup().location

module udf '../Shared.IaC.Templates/Common/IaC/Modules/UDF/FnGetStorageKind.bicep' = {
  name: 'udfStorKind'
   params:{
    pEnvironment: par_environment
   }
}

module stor '../Shared.IaC.Templates/Common/IaC/Modules/Storage/StorageV2.bicep' = {
  name: par_storageName
  params: {
    environment: par_environment
    storageAccountName:  par_storageName
    storageAccountSku: udf.outputs.GetStorageKind
    storageAccountLocation: par_location
  }
}



