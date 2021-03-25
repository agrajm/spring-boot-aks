# Introduction 
A pretty simple Spring boot project that communicates with Azure SQL DB and keeps secrets in Azure Key Vault, runs in Azure Kubernetes Service, communicates with both AKV and Azure SQL over Private Link.
This project and the associated DevOps pipelines can be seen and used as a starting point for your actual project in Azure. The final architecture looks like 

TODO: Add architecture diagram 

# Getting Started
1. Fork/Clone the repo and run the Build pipeline to build the infrastructure in Azure.
2. Run the Deploy pipeline to deploy the Spring Boot App 

# Pre-requisite

We will be using the [AKS-managed Azure AD Integration](https://docs.microsoft.com/en-us/azure/aks/managed-aad) for our cluster so that cluster administrators can configure kubernetes RBAC on user identity or group membership
To run the terraform template you would need to provide the ID of this admin group in the variable `aksadmingroupid`
