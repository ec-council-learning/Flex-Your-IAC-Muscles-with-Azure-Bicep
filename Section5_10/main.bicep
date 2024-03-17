
//az deployment group create 
//    --resource-group eccouncil-bicep 
//    --template-file ./main.bicep 
//    --parameters ./mrameters ./main.dev.bicepparam 

param par_VNetName string
param par_SubnetName string
param par_VMName string
param par_VMadminName string
@allowed([
  'dev'
  'uat'
  'prd'
])
param par_environment string 
@secure()
param par_VMadminPwd string
param par_location string = resourceGroup().location


module networking './IaC/Modules/Networking/VNetAndSubnet.bicep' = {
  name: 'networking'
  params: {
    vnetName: par_VNetName
    subnetName: par_SubnetName
    location: par_location
    environment:par_environment
  }
}

module nic  './IaC/Modules/Networking/NICdynIP.bicep' = {
  name: 'nic'
  params:{
     location: par_location
      subNetId: networking.outputs.subnetId
      vmName: par_VMName
      environment: par_environment
  }
  dependsOn:[
    networking
  ]
}

module vm './IaC/Modules/Compute/VMStandard.bicep' ={
  name : 'vm'
  params:{
    adminPassword: par_VMadminPwd
    adminUsername: par_VMadminName
    networkInterfaceId: nic.outputs.networkInterfaceId
    vmName: par_VMName
    locaton: par_location
    environment: par_environment
  }
  dependsOn: [
    nic
  ]
}
