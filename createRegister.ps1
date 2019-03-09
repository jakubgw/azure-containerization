az login


$myResourceGroup = "docker-test-resource-group"
$containerRegistry= "jgcontainerregister"
$dockerImageName= "docker-test-azure"
$containerRegistryServer= "jgcontainerregister.azurecr.io"

echo "Creating resource group"
az group create --name $myResourceGroup --location eastus

echo "Building image"
docker build -t $dockerImageName -f ./DockerTest/DockerTest/Dockerfile ./DockerTest/DockerTest

echo "Creating ACR and login into it "
az acr create --resource-group $myResourceGroup --name $containerRegistry --sku Basic
az acr login --name $containerRegistry

echo "Creating docker image tag"
docker tag $dockerImageName $containerRegistryServer/$dockerImageName`:v1
docker images | grep $dockerImageName

echo "Pushing into ACR"
docker push $containerRegistryServer/$dockerImageName`:v1
az acr repository list --name $containerRegistry --output table

echo "Cleaning up local"
docker rmi $containerRegistryServer/$dockerImageName`:v1
docker rmi $dockerImageName

echo "Runing image from ACR"
docker run -p 3000:80 -d  $containerRegistryServer/$dockerImageName`:v1


echo "Calling http://localhost:3000/api/dockertest"

Invoke-WebRequest -Uri "http://localhost:3000/api/dockertest"

# docker ps
# docker stop 447ea97aa351
# docker rmi docker rmi jgcontainerregister.azurecr.io/docker-test-azure:v1
# az group delete --name $myResourceGroup