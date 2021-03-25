output "acr_name" {
  description = "Login Server for ACR"
  value = azurerm_container_registry.acr.name
}

output "aks_kubeconfig_cmd" {
  value = format("az aks get-credentials --name %s --resource-group %s --overwrite-existing", "${var.aks-prefix}-aks", var.resource_group)
}

output "aks_kubeconfig_admin_cmd" {
  value = format("az aks get-credentials --name %s --resource-group %s --overwrite-existing --admin", "${var.aks-prefix}-aks", var.resource_group)
}

output "kube_admin_config_raw" {
  value = module.aks.kube_config_raw
}

output "aks_host"{
  value = module.aks.host
}

output "aks_node_resource_group" {
  value = module.aks.node_resource_group
}

output "aks_admin_host" {
  value = module.aks.admin_host
}

output "aks_id" {
  value = module.aks.aks_id
}

output "aks_resource_group" {
  value = var.resource_group
}

output "aks_cluster_name" {
  value = "${var.aks-prefix}-aks"
}

