

param par_kvName string
param par_kvSecretName string 




module kv '../Shared.IaC.Templates/Common/IaC/Modules/Security/AddKeyVaultValue.bicep' = {
  name: par_kvName
  params: {
    KeyVaultName: par_kvName
    secretName: par_kvSecretName
    secretValue: 'mysecretValue'
  }
}

