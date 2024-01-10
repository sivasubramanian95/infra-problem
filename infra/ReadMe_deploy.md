
# App Build
docker build -f Dockerfiles/Dockerfile.quotes -t quotes:1.0 .
docker build -f Dockerfiles/Dockerfile.newsfeed -t newsfeed:1.0 .
docker build -f Dockerfiles/Dockerfile.frontend -t frontend:1.0 .

docker tag quotes:1.0 vsivasubra95/quotes:v1
docker tag newsfeed:1.0 vsivasubra95/newsfeed:v1
docker tag frontend:1.0 vsivasubra95/frontend:v1

docker push vsivasubra95/quotes:v1
docker push vsivasubra95/newsfeed:v1
docker push vsivasubra95/frontend:v1

# Deploy Application

Please use the Makefile from the path provided under $WORKDIR/infra
make create-cluster will create the AKS cluster

make deploy-app 


