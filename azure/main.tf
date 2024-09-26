locals {
  region_location = module.resource_group.location
  resource_group  = module.resource_group.name
}

module "resource_group" {
  source = "./modules/resource_group"

  name     = var.resource_group_name
  location = var.resource_group_location

  tags = var.tags
}

module "virtual_network" {
  source = "./modules/vnet"

  vnet_name           = var.virtual_network_module.vnet_name
  vnet_address_space  = var.virtual_network_module.vnet_address_space
  resource_group_name = local.resource_group
  location            = local.region_location

  subnet1_name           = var.virtual_network_module.subnet1_name
  subnet1_address_prefix = var.virtual_network_module.subnet1_address_prefix
  subnet1_nsg_security_rules = [
    {
      name                       = "Allow_SSH"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      access                     = "Allow"
      priority                   = 100
      direction                  = "Inbound"
    }
  ]

  tags = var.tags
}

module "kubernetes_cluster" {
  source = "./modules/aks"

  location            = local.region_location
  resource_group_name = local.resource_group

  # Cluster Variables
  cluster_name                 = var.kubernetes_cluster_module.cluster_vars.cluster_name
  dns_prefix                   = var.kubernetes_cluster_module.cluster_vars.dns_prefix
  automatic_upgrade_channel    = var.kubernetes_cluster_module.cluster_vars.automatic_upgrade_channel
  image_cleaner_enabled        = var.kubernetes_cluster_module.cluster_vars.image_cleaner_enabled
  image_cleaner_interval_hours = var.kubernetes_cluster_module.cluster_vars.image_cleaner_interval_hours
  kubernetes_version           = var.kubernetes_cluster_module.cluster_vars.kubernetes_version
  node_resource_group          = var.kubernetes_cluster_module.cluster_vars.node_resource_group
  private_cluster_enabled      = var.kubernetes_cluster_module.cluster_vars.private_cluster_enabled
  sku_tier                     = var.kubernetes_cluster_module.cluster_vars.sku_tier

  # Network Profile
  network_plugin    = var.kubernetes_cluster_module.network_profile.network_plugin
  ip_versions       = var.kubernetes_cluster_module.network_profile.ip_versions
  service_cidrs     = var.kubernetes_cluster_module.network_profile.service_cidrs
  dns_service_ip    = var.kubernetes_cluster_module.network_profile.dns_service_ip
  load_balancer_sku = var.kubernetes_cluster_module.network_profile.load_balancer_sku

  # Linux Profile
  admin_username = var.kubernetes_cluster_module.linux_profile.admin_username
  ssh_public_key = file("./.ssh/id_rsa_aks.pub")

  # API Server Access Profile
  authorized_ip_ranges = var.kubernetes_cluster_module.api_server_access_profile.authorized_ip_ranges

  ## System Node Pool (Default)
  system_node_pool_name               = var.kubernetes_cluster_module.np_system.node_pool_name
  system_vm_size                      = var.kubernetes_cluster_module.np_system.vm_size
  system_node_count                   = var.kubernetes_cluster_module.np_system.node_count
  system_vnet_subnet_id               = module.virtual_network.subnet1_id
  system_host_encryption_enabled      = var.kubernetes_cluster_module.np_system.host_encryption_enabled
  system_only_critical_addons_enabled = var.kubernetes_cluster_module.np_system.only_critical_addons_enabled
  system_temporary_name_for_rotation  = var.kubernetes_cluster_module.np_system.temporary_name_for_rotation
  system_node_labels                  = var.kubernetes_cluster_module.np_system.node_labels

  ## NP One Node Pool
  np_one_node_pool_name          = var.kubernetes_cluster_module.np_one.node_pool_name
  np_one_vm_size                 = var.kubernetes_cluster_module.np_one.vm_size
  np_one_node_count              = var.kubernetes_cluster_module.np_one.node_count
  np_one_vnet_subnet_id          = module.virtual_network.subnet1_id
  np_one_host_encryption_enabled = var.kubernetes_cluster_module.np_one.host_encryption_enabled
  np_one_node_labels             = var.kubernetes_cluster_module.np_one.node_labels

  tags = var.tags
}

module "kubeconfig_file" {
  source = "./modules/local/sensitive_file"

  file_permission = "0400"
  file_name       = "${path.module}/${var.aks_kubeconfig_target_file}"
  file_content    = module.kubernetes_cluster.kube_config_raw
}
