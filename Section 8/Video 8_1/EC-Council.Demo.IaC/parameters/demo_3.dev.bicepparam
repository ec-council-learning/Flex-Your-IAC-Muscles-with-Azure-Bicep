using '../demo_3.bicep'

param par_environment = 'dev'
param par_subnetNames =  [ 
  'vmSubnet'
  'sqlSubnet'
  'gwSubnet' 
]

