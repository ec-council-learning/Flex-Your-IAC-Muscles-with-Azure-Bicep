@allowed([
  'dev'
  'sbx'
  'uat'
  'prd'
])
param par_environment string

param par_vnetName string
param par_subnetNameWeb string
param par_location string = resourceGroup().location
param par_VmName string
param par_VmAdminName string
param par_KeyVaultName string
param par_KVSecretVm string


var var_subnetWebAddrPrefix = '10.0.1.0/24'


// Create the Network Security Groups
module nsg_web_allow '../Shared.IaC.Templates/Common/IaC/Modules/Networks/NSGWebHTTPOnly.bicep' = {
  name: 'nsgWebAllow-deploy'
  params: {
    environment: par_environment
    location: par_location
  }
}

// Create the Vnet
module vnet '../Shared.IaC.Templates/Common/IaC/Modules/Networks/VNet.bicep' = {
  name: '${par_vnetName}-deploy'
  params: {
    environment: par_environment
    vnetName: par_vnetName
    location: par_location
  }
}

// Create subnets
module snWeb '../Shared.IaC.Templates/Common/IaC/Modules/Networks/Subnet.bicep' = {
  name: '${par_subnetNameWeb}-deploy'
  params: {
    addressPrefix: var_subnetWebAddrPrefix
    subnetName: par_subnetNameWeb
    vnetName: vnet.outputs.vnetNameFullname
    networkSecurtyGroupId: nsg_web_allow.outputs.nsgId
  }
}

// Create Storage account for VM diagnostics
module diaStor '../Shared.IaC.Templates/Common/IaC/Modules/Storage/StorageV2.bicep' = {
  name: 'stodiag-deploy'
  params: {
    environment: par_environment
    storageAccountName: 'vmdiag' 
    storageAccountSku: 'Standard_LRS'
     storageAccountLocation: par_location
  }
}

// Create the VM NIC and assign to subNet FrontEnd
module nic '../Shared.IaC.Templates/Common/IaC/Modules/Networks/NIC_DynamicIP.bicep' = {
  name: 'nic-deploy'
  params: {
    environment: par_environment
    location: par_location
    subNetId: snWeb.outputs.subnetId
    vmName: par_VmName
  }
}

// Get password from Key Vault
resource kv 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
  name: par_KeyVaultName
}

module vm '../Shared.IaC.Templates/Common/IaC/Modules/Compute/VM_Standard.bicep' = {
  name: 'vm-deploy'
  params: {
    adminPassword: kv.getSecret(par_KVSecretVm)
    adminUsername: par_VmAdminName
    diagStorageUri: diaStor.outputs.storageAccountPrimEndpointBlob
    environment: par_environment
    networkInterfaceId: nic.outputs.networkInterfaceId
    vmName: par_VmName
    locaton: par_location
  }
}

// Add the IIS extension
module webext '../Shared.IaC.Templates/Common/IaC/Modules/Compute/VM_IISExtension.bicep' = {
  name: 'webext-deploy'
  params: {
    location: par_location
    vmName: vm.outputs.vmFullName
  }
  dependsOn:[
    vm
  ]
}
