. "../setupVariables.ps1"

az login

az group create --name $k8sResourceGroup --location westeurope
echo "Create cluster"
az aks create `
    --resource-group $k8sResourceGroup `
    --name $k8sClusterName `
    --node-count 1 `
    --enable-addons monitoring `
    --generate-ssh-keys

    
echo "Configure Azure Kubectl"
az aks install-cli
$env:path += 'C:\Users\jakub.gwozdz\.azure-kubectl'

echo "Log into Kubectl"
az aks get-credentials --resource-group $k8sResourceGroup --name $k8sClusterName

echo "list nodes "
kubectl get nodes



    