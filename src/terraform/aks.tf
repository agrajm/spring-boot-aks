module "aks" {
  source                           = "Azure/aks/azurerm"
  resource_group_name              = azurerm_resource_group.core.name
  kubernetes_version               = var.kubernetes-version
  orchestrator_version             = var.kubernetes-version
  prefix                           = var.aks-prefix
  network_plugin                   = "azure"
  vnet_subnet_id                   = azurerm_subnet.akssubnet.id
  os_disk_size_gb                  = 50
  sku_tier                         = "Paid" # defaults to Free
  enable_role_based_access_control = true
  rbac_aad_admin_group_object_ids  = [var.aks_admin_group_id]
  rbac_aad_managed                 = true
  private_cluster_enabled          = false # default value is true
  enable_http_application_routing  = false
  enable_azure_policy              = true
  enable_auto_scaling              = true
  agents_min_count                 = 1
  agents_max_count                 = 2
  agents_count                     = null # Please set `agents_count` `null` while `enable_auto_scaling` is `true` to avoid possible `agents_count` changes.
  agents_max_pods                  = 100
  agents_pool_name                 = "exnodepool"
  agents_availability_zones        = var.aks-agents-az
  agents_type                      = "VirtualMachineScaleSets"

  agents_labels = {
    "nodepool" : "defaultnodepool"
  }

  agents_tags = {
    "Agent" : "defaultnodepoolagent"
  }

  network_policy                 = "azure"
  net_profile_dns_service_ip     = "10.0.0.10"
  net_profile_docker_bridge_cidr = "170.10.0.1/16"
  net_profile_service_cidr       = "10.0.0.0/16"

  depends_on = [azurerm_subnet.akssubnet]
}

resource "azurerm_container_registry" "acr" {
  name                     = var.acr_name
  resource_group_name      = azurerm_resource_group.core.name
  location                 = azurerm_resource_group.core.location
  sku                      = "Standard"
  admin_enabled            = false

  depends_on = [module.aks]

  provisioner local-exec {
    command                    = "az aks update --resource-group ${azurerm_resource_group.core.name} --name ${var.aks-prefix}-aks --attach-acr ${var.acr_name}"
    environment                = {
      AZURE_EXTENSION_USE_DYNAMIC_INSTALL = "yes_without_prompt"
    }
  }
}


