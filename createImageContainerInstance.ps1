az login

$myResourceGroup = "docker-test-resource-group"

$containerName= "container-instance-test"
$dnsName= "container-instance-test"
$dockerImageName= "docker-test-azure"
$containerRegistry= "jgcontainerregister"
$containerRegistryServer= "jgcontainerregister.azurecr.io"
$keyVault="jgcontainerkeyvault"     


echo "Creating resource group"
az group create --name $myResourceGroup --location eastus
echo "ACR login"
az acr login --name $containerRegistry
echo "ACR admin access"
az acr update -n $containerRegistry --admin-enabled true

echo "Get ACR password"
$password  = az acr credential show --name $containerRegistry --query "passwords[0].value"
echo "Get ACR login"
$user = az acr credential show --name jgcontainerregister --query "username"

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

echo "Calling $dnsName.eastus.azurecontainer.io/api/dockertest"
Invoke-WebRequest -Uri "$dnsName.eastus.azurecontainer.io/api/dockertest"
