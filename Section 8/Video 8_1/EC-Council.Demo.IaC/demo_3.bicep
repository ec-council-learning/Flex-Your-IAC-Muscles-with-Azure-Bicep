
@allowed([
  'dev'
  'sbx'
  'uat'
  'prd'
])
param par_environment string
param par_location string = resourceGroup().location

param par_subnetNames array


module vnet1 '../Shared.IaC.Templates/Common/IaC/Modules/Networks/VNet.bicep' = {
  name: 'vnet'
  params: {
    environment: par_environment 
    vnetName: 'vnet01'
    location: par_location
  }
}

module subNet '../Shared.IaC.Templates/Common/IaC/Modules/Networks/Subnet.bicep' = [for (subnetName, i) in par_subnetNames : {
  name: subnetName
  params: {
    addressPrefix: '10.0.${i+1}.0/28'
    environment: par_environment
    subnetName:   subnetName
    vnetName: 'vnet01'
  }
  dependsOn: [
    vnet1 ]
}]




