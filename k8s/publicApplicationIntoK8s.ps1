# Before run createRegister.ps1 - it will create resource group and push image the ACR 
. "../setupVariables.ps1"

az login


echo "Configure Azure Kubectl"
az aks install-cli
$env:path += 'C:\Users\jakub.gwozdz\.azure-kubectl'

echo " Get the id of the service principal configured for AKS"
$clientId = az aks show `
 --resource-group $k8sResourceGroup `
 --name $k8sClusterName `
 --query "servicePrincipalProfile.clientId" `
 --output tsv

echo "Get the ACR registry resource id"
$acrId= az acr show `
    --name $containerRegistry `
    --resource-group $myResourceGroup `
    --query "id" --output tsv

echo "Create role assignment"
az role assignment create --assignee $clientId --role acrpull --scope $acrId

echo "Log into kubectl"
az aks get-credentials --resource-group $k8sResourceGroup --name $k8sClusterName

echo "Apply k8s configuration"
kubectl apply -f ./deployment.yaml
kubectl apply -f ./service.yaml

echo "Check services"
kubectl get service 
# kubectl get service --watch

echo "Check pods"


