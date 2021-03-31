# Introduction 
A pretty simple Spring boot project that communicates with Azure SQL DB and keeps secrets in Azure Key Vault, runs in Azure Kubernetes Service, communicates with both AKV and Azure SQL over Private Link. This project and the associated DevOps pipelines can be seen and used as a starting point for your actual project in Azure. 

# Getting Started
Follow the set of articles I plan to write as I go through this journey
1. The first article will set up the initial infrastructure in Azure using Terraform and Azure Devops. Then we dockerize the app and push it to a container registry -- all from our pipelines and finally deploy the build to AKS using kubelogin, again from our pipeline. Check out [this article](https://agraj.medium.com/running-your-microservices-securely-on-aks-417a110b2e76) to follow along. 

# Pre-requisite

We will be using the [AKS-managed Azure AD Integration](https://docs.microsoft.com/en-us/azure/aks/managed-aad) for our cluster so that cluster administrators can configure kubernetes RBAC on user identity or group membership
To run the terraform template you would need to provide the ID of this admin group in the variable `aksadmingroupid`
