using '../demo_1.bicep'

param par_environment = 'dev'
param par_storageName = az.getSecret('<add your subscription id>', 'eccouncil-bicep', 'kv-eccouncil-dev','mysecret' )

