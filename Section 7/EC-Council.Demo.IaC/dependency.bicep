
@allowed([
  'dev'
  'sbx'
  'uat'
  'prd'
])
param par_environment string

param par_storName1 string 
@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_ZRS'
])
param par_storageSku string

param par_location string = resourceGroup().location

param par_vmName string
@secure()
param par_vmPassword string
param par_vmUsername string


module stor1 '../Shared.IaC.Templates/Common/IaC/Modules/Storage/StorageV2.bicep' = {
  name: par_storName1
  params: {
    environment: par_environment
    storageAccountName:  par_storName1
    storageAccountSku: par_storageSku
    storageAccountLocation: par_location
  }
}


module networking '../Shared.IaC.Templates/Common/Iac/Modules/Networks/VNet_Subnet.bicep' = {
  name: 'vnet01'
  params: {
    environment: par_environment
    subnetName: '${par_vmName}subnet'
    vnetName: 'vnet01'
    location: par_location
  }
}

module nic '../Shared.IaC.Templates/Common/IaC/Modules/Networks/NIC_DynamicIP.bicep' = {
  name: 'dynip'
  params: {
    environment: par_environment
    location:  par_location
    subNetId:  networking.outputs.subnetId
    vmName: par_vmName
  }
}

module vm '../Shared.IaC.Templates/Common/IaC/Modules/Compute/VM_Standard.bicep' ={
  name : 'vm'
  params:{
    adminPassword: par_vmPassword
    adminUsername: par_vmUsername
    networkInterfaceId: nic.outputs.networkInterfaceId
    vmName: par_vmName
    locaton: par_location
    environment: par_environment
  }

}

