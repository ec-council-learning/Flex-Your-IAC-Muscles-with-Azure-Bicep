param pEnvironment string

func GetStorageKind( environ string ) string => 

( environ == 'prd' ? 'Standard_GRS' : 'Standard_LRS' )

output GetStorageKind string = GetStorageKind(pEnvironment)
