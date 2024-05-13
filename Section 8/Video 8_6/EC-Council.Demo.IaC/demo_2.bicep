
@allowed([
  'dev'
  'sbx'
  'uat'
  'prd'
])
param par_environment string
param par_sqlName string
param par_sqlAdminLogin string
param par_location string = resourceGroup().location
param par_kvName string
param par_kvSecretName string 

resource kv 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
  name: par_kvName
  // scope: resourceGroup('rg-other')  - if key vault is in a different resource group
}


module mssql '../Shared.IaC.Templates/Common/IaC/Modules/Database/MSSQLServer.bicep' = {
  name: par_sqlName
  params: {
    adminLogin: par_sqlAdminLogin
    adminPassword: kv.getSecret(par_kvSecretName)
    location: par_location
    sqlServerName: par_sqlName
     environment: par_environment
  }
}


