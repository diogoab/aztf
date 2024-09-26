output "vnet_id" {
  value = azurerm_virtual_network.this.id
}

output "subnet1_id" {
  value = azurerm_subnet.subnet1.id
}
