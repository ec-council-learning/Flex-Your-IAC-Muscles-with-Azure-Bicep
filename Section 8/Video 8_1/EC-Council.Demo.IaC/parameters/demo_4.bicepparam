using '../demo_4.bicep'

param par_vnets = [

  {
    name: 'webzone-1-vnet'
    addressPrefix: '10.1.0.0/24'
    subnets: [
      {
        name: 'frontend'
        subnetPrefix: '10.1.0.0/28'
      }
      {
        name: 'sql'
        subnetPrefix: '10.1.0.64/28'
      }
      {
        name: 'appservice'
        subnetPrefix: '10.1.0.128/28'
      }
    ]
  }
  {
    name: 'webzone-2-vnet'
    addressPrefix: '10.2.0.0/24'
    subnets: [
      {
        name: 'frontend'
        subnetPrefix: '10.2.0.0/28'
      }
    ]
  }

]

