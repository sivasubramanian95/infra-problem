
# Create AKS Cluster

The AKS (Azure Kubernetes Service) cluster is created by using Terraform. Please use the below Make commands to create and operate some basic functionalities of Cluster including deploying the newsfeed application.
The terraform scripts are placed in infra-problem/infra

*Environment variable*:

* `WORKDIR`: The path where you have the repository infra-problem

   `export $WORKDIR= /home/$USER/infra-problem`

Export the above environmental variable before running the Make commands.

Please run the following commands for the operations.

# Create Plan

To perform a terraform dry-run, This would create a main.tfplan in your workspace.


 `make create-plan`

# Create Cluster

To create the AKS cluster in Azure Cloud

   `make create-cluster`

# Get Credentials

Once the create script is successfull, To access the cluster provided you have adequate permissions.

   `make get-credential`

This would set the cluster kubeconfig in your `.kube` directory

# Get Nodes
    
To confirm that you have access to cluster and to check the number of nodes created in the cluster,

   `make get-nodes`

# Deploy Application

Ensure the cluster is healthy and you can access the cluster with the KUBECONFIG.

Use the following command to deploy the newsfeed application in the Cluster.

   `make deploy-app`

# Delete Cluster

Once the development activity is completed and when you plan to delete the cluster,

   `make delete-cluster`

Note: Ensure this operation is not reversible and the data can be lost. Kindly accept and continue with a "yes".

# Testing of Application

Please use the External IP of the loadbalancer deployed to access the frontend application.

   `kubectl get svc`

You can access the application from browser on http://$EXTERNAL_IP:8080


# Docker build

The docker images are available in public repository docker hub. Also the image can be built locally using the below commands.

```bash
$ docker build -f Dockerfiles/Dockerfile.quotes -t quotes:1.0 .
$ docker build -f Dockerfiles/Dockerfile.newsfeed -t newsfeed:1.0 .
$ docker build -f Dockerfiles/Dockerfile.frontend -t frontend:1.0 .
$ docker tag quotes:1.0 vsivasubra95/quotes:v1
$ docker tag newsfeed:1.0 vsivasubra95/newsfeed:v1
$ docker tag frontend:1.0 vsivasubra95/frontend:v1
$ docker push vsivasubra95/quotes:v1
$ docker push vsivasubra95/newsfeed:v1
$ docker push vsivasubra95/frontend:v1
```

# Deploy Application

Please use the Makefile from the path provided under $WORKDIR/infra
make create-cluster will create the AKS cluster

   `make deploy-app` 

# Notes on Future Work

There are a number of areas to improve the infrastructure and application deployment lifecycle.

    * Docker images can be optimised and improved considering the size of the current image. 
    * Newsfeed application is deployed using kubernetes manifests and Could be migrated to helm charts which will help in the enhancement of microservices.
    * Introducing Continous Integration and Deployment using tools like Jenkins and improvising Scripts to deploy. Currently the project used Make for simplification of manual deployment.
    * Introducing more tools for monitoring, autoscaling, resource request in the Kubernetes for better management.
     

