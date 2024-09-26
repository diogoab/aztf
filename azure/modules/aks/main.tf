resource "azurerm_kubernetes_cluster" "this" {
  name                         = var.cluster_name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  dns_prefix                   = var.dns_prefix
  automatic_upgrade_channel    = var.automatic_upgrade_channel
  image_cleaner_enabled        = var.image_cleaner_enabled
  image_cleaner_interval_hours = var.image_cleaner_interval_hours
  kubernetes_version           = var.kubernetes_version
  node_resource_group          = var.node_resource_group
  private_cluster_enabled      = var.private_cluster_enabled
  sku_tier                     = var.sku_tier

  network_profile {
    network_plugin    = var.network_plugin
    ip_versions       = var.ip_versions
    service_cidrs     = var.service_cidrs
    dns_service_ip    = var.dns_service_ip
    load_balancer_sku = var.load_balancer_sku
  }

  linux_profile {
    admin_username = var.admin_username

    ssh_key {
      key_data = var.ssh_public_key
    }
  }

  api_server_access_profile {
    authorized_ip_ranges = var.authorized_ip_ranges
  }

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name           = var.system_node_pool_name
    vm_size        = var.system_vm_size
    node_count     = var.system_node_count
    vnet_subnet_id = var.system_vnet_subnet_id

    zones = ["1", "2", "3"]

    host_encryption_enabled      = var.system_host_encryption_enabled
    only_critical_addons_enabled = var.system_only_critical_addons_enabled
    temporary_name_for_rotation  = var.system_temporary_name_for_rotation

    upgrade_settings {
      drain_timeout_in_minutes      = 0
      max_surge                     = "10%"
      node_soak_duration_in_minutes = 0
    }

    node_labels = var.system_node_labels

    tags = var.tags
  }

  lifecycle {
    ignore_changes = [network_profile.0.load_balancer_profile.0.outbound_ip_address_ids]
  }

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "np_one" {
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id

  name           = var.np_one_node_pool_name
  vm_size        = var.np_one_vm_size
  node_count     = var.np_one_node_count
  vnet_subnet_id = var.np_one_vnet_subnet_id

  os_type = "Linux"
  mode    = "User"
  zones   = ["1", "2", "3"]

  host_encryption_enabled = var.np_one_host_encryption_enabled

  upgrade_settings {
    drain_timeout_in_minutes      = 0
    max_surge                     = "10%"
    node_soak_duration_in_minutes = 0
  }

  node_labels = var.np_one_node_labels

  tags = var.tags
}
