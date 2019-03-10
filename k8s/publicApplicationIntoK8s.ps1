az login

$myResourceGroup = "docker-test-resource-group"
$containerRegistry= "jgcontainerregister"
$k8sClusterName = 'jgcluster'

echo "Configure Azure Kubectl"
az aks install-cli
$env:path += 'C:\Users\jakub.gwozdz\.azure-kubectl'

echo " Get the id of the service principal configured for AKS"
$clientId = az aks show `
 --resource-group $myResourceGroup `
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
az aks get-credentials --resource-group $myResourceGroup --name $k8sClusterName

echo "Apply k8s configuration"
# kubectl apply -f ./deployment.yaml
# kubectl apply -f ./service.yaml

kubectl get service 
# kubectl get service --watch



