resource "azurerm_kubernetes_cluster" "aks" {
  dns_prefix = "${var.aks-prefix}-aks"
  location = azurerm_resource_group.core.location
  name = "${var.aks-prefix}-aks"
  resource_group_name = azurerm_resource_group.core.name

  role_based_access_control {
    enabled = true
    azure_active_directory {
      managed = true
      admin_group_object_ids = [var.aks_admin_group_id]
      tenant_id = var.tenant_id
    }
  }

  default_node_pool {
    name                = "sysnodepool"
    node_count          = var.system_nodepool_nodes_count
    vm_size             = var.system_nodepool_vm_size
    vnet_subnet_id      = azurerm_subnet.akssubnet.id
    max_pods            = 100
    min_count           = 1
    max_count           = 2
    enable_auto_scaling = true
    availability_zones  = var.aks-agents-az
    type                = "VirtualMachineScaleSets"
  }

  kubernetes_version = var.kubernetes-version

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"  # calico is another option

    dns_service_ip = "10.0.0.10"
    docker_bridge_cidr = "172.17.0.1/16"
    service_cidr = "10.0.0.0/16"

    load_balancer_sku = "standard"
    outbound_type = "userDefinedRouting"
  }

  addon_profile {

    azure_policy {
      enabled = true
    }
    http_application_routing {
      enabled = false
    }
    aci_connector_linux {
      enabled = false
    }
    oms_agent {
      enabled = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id
    }
  }

  identity {
    type = "SystemAssigned"
  }

  private_cluster_enabled = true

  depends_on = [azurerm_subnet.akssubnet,
    azurerm_route_table.rt,
    azurerm_subnet_route_table_association.aks_subnet_association]
}

resource "azurerm_log_analytics_workspace" "main" {
  name                = "${var.aks-prefix}-lg-workspace"
  location            = azurerm_resource_group.core.location
  resource_group_name = azurerm_resource_group.core.name
  sku                 = var.log_analytics_workspace_sku
  retention_in_days   = var.log_retention_in_days

  tags = var.tags
}

resource "azurerm_log_analytics_solution" "main" {
  solution_name         = "ContainerInsights"
  location            = azurerm_resource_group.core.location
  resource_group_name = azurerm_resource_group.core.name
  workspace_resource_id = azurerm_log_analytics_workspace.main.id
  workspace_name        = azurerm_log_analytics_workspace.main.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }

  tags = var.tags
}



resource "azurerm_container_registry" "acr" {
  name                     = var.acr_name
  resource_group_name      = azurerm_resource_group.core.name
  location                 = azurerm_resource_group.core.location
  sku                      = "Standard"
  admin_enabled            = false

  depends_on = [azurerm_kubernetes_cluster.aks]

  provisioner local-exec {
    command                    = "az aks update --resource-group ${azurerm_resource_group.core.name} --name ${var.aks-prefix}-aks --attach-acr ${var.acr_name}"
    environment                = {
      AZURE_EXTENSION_USE_DYNAMIC_INSTALL = "yes_without_prompt"
    }
  }
}