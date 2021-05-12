# Introduction 
A pretty simple Spring boot project that communicates with Azure SQL DB and keeps secrets in Azure Key Vault, runs in Azure Kubernetes Service, communicates with both AKV and Azure SQL over Private Link. This project and the associated DevOps pipelines can be seen and used as a starting point for your actual project in Azure. The final architecture looks like 

# Getting Started
This has been broken down into following set of articles:

1. [The basic setup](https://itnext.io/running-your-microservices-securely-on-aks-417a110b2e76?sk=40002aac0f7d5af48fc781c844cfb9ba) - Creating a Simple Spring Boot App deployed on AKS talking to Azure SQL db. Everything is terraformized and run via Azure DevOps. 
2. [Adding Identity & Governance](https://medium.com/microsoftazure/secure-your-microservices-on-aks-part-2-5496bf2ba00c?sk=78fa24844772d814636b8c00e6d73824) - Using Azure AD Managed Identities to access Key Vault & SQL and using OPA based Azure Policy for Governance
3. [Securing the Network](https://medium.com/microsoftazure/secure-your-microservices-on-aks-part-3-the-network-dfde7d26af8c?sk=d29c9cd812354a1a396c0d73cf110425) - Looks into using enabling Private Links for Key Vault & SQL, and at the end using Private AKS Cluster with Azure Firewall and some basic thoughts on Network Policies

