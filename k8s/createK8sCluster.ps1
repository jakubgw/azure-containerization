. "../setupVariables.ps1"

az login

echo "Create cluster"
az aks create `
    --resource-group $myResourceGroup `
    --name $k8sClusterName `
    --node-count 1 `
    --enable-addons monitoring `
    --generate-ssh-keys

    
echo "Configure Azure Kubectl"
az aks install-cli
$env:path += 'C:\Users\jakub.gwozdz\.azure-kubectl'

echo "Log into Kubectl"
az aks get-credentials --resource-group $myResourceGroup --name $k8sClusterName

echo "list nodes "
kubectl get nodes



    