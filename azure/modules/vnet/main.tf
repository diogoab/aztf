resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name

  address_space = [var.vnet_address_space]

  tags = var.tags
}

resource "azurerm_subnet" "subnet1" {
  name                 = var.subnet1_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name

  address_prefixes = [var.subnet1_address_prefix]
}

resource "azurerm_network_security_group" "subnet1_nsg" {
  name                = "${var.subnet1_name}_nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = var.subnet1_nsg_security_rules != null ? var.subnet1_nsg_security_rules : []
    content {
      name                       = security_rule.value.name
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
      access                     = security_rule.value.access
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction

      # description                                = "*"
      # source_port_ranges                         = ["*"]
      # destination_port_ranges                    = ["*"]
      # source_address_prefixes                    = ["*"]
      # destination_address_prefixes               = ["*"]
    }
  }

  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "subnet1" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.subnet1_nsg.id
}
