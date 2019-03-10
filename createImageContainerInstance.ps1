# Before run createRegister.ps1 - it will create resource group and push image the ACR 

. "./setupVariables.ps1"

az login

echo "ACR login"
az acr login --name $containerRegistry
echo "ACR admin access"
az acr update -n $containerRegistry --admin-enabled true

echo "Get ACR password"
$password  = az acr credential show --name $containerRegistry --query "passwords[0].value"
echo "Get ACR login"
$user = az acr credential show --name $containerRegistry --query "username"

echo "Creating container instance"
az container create `
     --resource-group $myResourceGroup  `
     --name $containerName `
     --image $containerRegistryServer/$dockerImageName`:v1 `
     --dns-name-label $dnsName `
     --registry-username $user `
     --registry-password $password `
     --ports 80

     
echo "Checking container instance state"
az container show `
    --resource-group  $myResourceGroup  `
    --name $containerName `
    --query "{FQDN:ipAddress.fqdn,ProvisioningState:provisioningState}" `
    --out table

echo "Calling $dnsName.westeurope.azurecontainer.io/api/dockertest"
Invoke-WebRequest -Uri "$dnsName.westeurope.azurecontainer.io/api/dockertest"
