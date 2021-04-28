output "acr_name" {
  description = "Login Server for ACR"
  value = azurerm_container_registry.acr.name
}

output "aks_kubeconfig_cmd" {
  value = format("az aks get-credentials --name %s --resource-group %s --overwrite-existing", "${var.aks-prefix}-aks", var.resource_group)
}

output "kube_admin_config_raw" {
  value = azurerm_kubernetes_cluster.aks1.kube_config_raw
}

output "aks_host"{
  value = azurerm_kubernetes_cluster.aks1.fqdn
}

output "aks_node_resource_group" {
  value = azurerm_kubernetes_cluster.aks1.node_resource_group
}

output "aks_id" {
  value = azurerm_kubernetes_cluster.aks1.id
}

output "aks_resource_group" {
  value = azurerm_resource_group.core.name
}

output "aks_cluster_name" {
  value = "${var.aks-prefix}-aks"
}

output "managed_identity_resource_id" {
  value = azurerm_user_assigned_identity.managed_identity.id
}

output "managed_identity_client_id" {
  value = azurerm_user_assigned_identity.managed_identity.client_id
}

output "managed_identity_principal_id" {
  value = azurerm_user_assigned_identity.managed_identity.principal_id
}

output "sql_private_link_endpoint_ip" {
  value = data.azurerm_private_endpoint_connection.sql_plink_pe_conn.private_service_connection.0.private_ip_address
}