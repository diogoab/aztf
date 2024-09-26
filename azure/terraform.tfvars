## Azurerm Resources
# Provider
subscription_id = "<your_subscription_id>"

# Resource Group
resource_group_name     = "main_rg"
resource_group_location = "eastus"

# All resources
tags = {
  managed_by = "terraform"
}

# Virtual Network
virtual_network_module = {
  vnet_name              = "main_vnet"
  vnet_address_space     = "10.0.0.0/16"
  subnet1_name           = "subnet1"
  subnet1_address_prefix = "10.0.1.0/24"
}

# AKS Cluster
kubernetes_cluster_module = {
  cluster_vars = {
    cluster_name                 = "main_aks"
    dns_prefix                   = "aks-164976843"
    automatic_upgrade_channel    = "rapid"
    image_cleaner_enabled        = false
    image_cleaner_interval_hours = 48
    kubernetes_version           = "1.30"
    node_resource_group          = "main_aks_nodes_rg"
    private_cluster_enabled      = false
    sku_tier                     = "Standard"
  },
  network_profile = {
    network_plugin    = "azure"
    ip_versions       = ["IPv4"]
    service_cidrs     = ["10.1.0.0/16"]
    dns_service_ip    = "10.1.0.10"
    load_balancer_sku = "standard"
  },
  linux_profile = {
    admin_username = "adminuser"
  },
  api_server_access_profile = {
    authorized_ip_ranges = [
      "SEU_IP/32", // Para acesso via Kubectl/kubeconfig
    ]
  },
  np_system = {
    node_pool_name               = "system"
    vm_size                      = "Standard_B2ps_v2"
    node_count                   = 1
    host_encryption_enabled      = false
    only_critical_addons_enabled = true
    temporary_name_for_rotation  = "tmpsystemnp"
    node_labels = {
      "nodepool" = "system"
    }
  },
  np_one = {
    node_pool_name          = "one"
    vm_size                 = "Standard_B2ps_v2"
    node_count              = 1
    host_encryption_enabled = false
    node_labels = {
      "nodepool" = "one"
    }
  }
}

# Local sentitive file for kubeconfig
aks_kubeconfig_target_file = ".kube/aks_config.yaml"
