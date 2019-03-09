
echo "Building image"
# docker build -t docker-test-azure -f ./DockerTest/DockerTest/Dockerfile --no-cache ./DockerTest/DockerTest
docker build -t docker-test-azure -f ./DockerTest/DockerTest/Dockerfile ./DockerTest/DockerTest

echo "Showing builded image"
docker images | grep docker-test-azure

echo "Running container"
docker run -p 3000:80 -d docker-test-azure

echo "Showing active containers"
docker ps

echo "Calling http://localhost:3000/api/dockertest"

Invoke-WebRequest -Uri "http://localhost:3000/api/dockertest"

# docker exec -it 447ea97aa351 bash
# docker stop 447ea97aa351
# docker ps -a | grep 447ea97aa351
# docker rm 447ea97aa351
# docker rmi docker-test-azure
