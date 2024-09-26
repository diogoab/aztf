output "kube_config_raw" {
  value = azurerm_kubernetes_cluster.this.kube_config_raw
}

output "node_resource_group" {
  value = azurerm_kubernetes_cluster.this.node_resource_group
}

output "cluster_id" {
  value = azurerm_kubernetes_cluster.this.id
}
