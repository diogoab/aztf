## Provider
variable "subscription_id" {
  description = "The Azure subscription ID"
  type        = string
}

## Resource Group
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "resource_group_location" {
  description = "The location of the resource group"
  type        = string
}

## All resources
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}

## Virtual Network
variable "virtual_network_module" {
  description = "A map of variables to pass to the virtual network module"
  type = object({
    vnet_name              = string
    vnet_address_space     = string
    subnet1_name           = string
    subnet1_address_prefix = string
  })
}

## AKS Cluster
variable "kubernetes_cluster_module" {
  description = "A map of variables to pass to the kubernetes cluster module"
  type = object({
    cluster_vars = object({
      cluster_name                 = string
      dns_prefix                   = string
      automatic_upgrade_channel    = string
      image_cleaner_enabled        = bool
      image_cleaner_interval_hours = number
      kubernetes_version           = string
      node_resource_group          = string
      private_cluster_enabled      = bool
      sku_tier                     = string
    })
    network_profile = object({
      network_plugin    = string
      ip_versions       = list(string)
      service_cidrs     = list(string)
      dns_service_ip    = string
      load_balancer_sku = string
    })
    linux_profile = object({
      admin_username = string
    })
    api_server_access_profile = object({
      authorized_ip_ranges = list(string)
    })
    np_system = object({
      node_pool_name               = string
      vm_size                      = string
      node_count                   = number
      host_encryption_enabled      = bool
      only_critical_addons_enabled = bool
      temporary_name_for_rotation  = string
      node_labels                  = map(string)
    })
    np_one = object({
      node_pool_name          = string
      vm_size                 = string
      node_count              = number
      host_encryption_enabled = bool
      node_labels             = map(string)
    })
  })
}

# Kubeconfig File
variable "aks_kubeconfig_target_file" {
  description = "The path to the kubeconfig file, including the file itself"
  type        = string
}
