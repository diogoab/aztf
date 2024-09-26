# Cluster variables
variable "cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
}

variable "location" {
  description = "The region of the AKS cluster"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group for the AKS cluster"
  type        = string
}

variable "dns_prefix" {
  description = "The DNS prefix specified for the AKS cluster"
  type        = string
}

variable "automatic_upgrade_channel" {
  description = "The upgrade channel selected for the AKS cluster"
  type        = string
}

variable "image_cleaner_enabled" {
  description = "Enable the image cleaner for the AKS cluster"
  type        = bool
}

variable "image_cleaner_interval_hours" {
  description = "The interval in hours to run the image cleaner"
  type        = number
}

variable "kubernetes_version" {
  description = "The version to use when creating the AKS cluster"
  type        = string
}

variable "node_resource_group" {
  description = "Name of the new resource group for the node resources"
  type        = string
}

variable "private_cluster_enabled" {
  description = "Expose the API server only on internal IP addresses"
  type        = bool
}

variable "sku_tier" {
  description = "The SKU tier for the AKS cluster"
  type        = string
}

# Network Profile
variable "network_plugin" {
  description = "The network plugin to use for the AKS cluster"
  type        = string
}

variable "ip_versions" {
  description = "IPv4 or dual stack IPv4/IPv6"
  type        = list(string)
}

variable "service_cidrs" {
  description = "CIDR range for services, IPv4 or dual stack IPv4/IPv6"
  type        = list(string)
}

variable "dns_service_ip" {
  description = "IPv4 address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns)"
  type        = string
}

variable "load_balancer_sku" {
  description = "The SKU of the Load Balancer"
  type        = string
}

# Linux Profile
variable "admin_username" {
  description = "The username for the Linux Virtual Machines"
  type        = string
}

variable "ssh_public_key" {
  description = "The SSH public key"
  type        = string
}

# API Server Access Profile
variable "authorized_ip_ranges" {
  description = "IP ranges authorized to access the API server"
  type        = list(string)
}

# System Node Pool (Default)
variable "system_node_pool_name" {
  description = "The name of the system node pool"
  type        = string
}

variable "system_vm_size" {
  description = "The size of the Virtual Machines in the node pool"
  type        = string
}

variable "system_node_count" {
  description = "The number of nodes in the node pool"
  type        = number
}

variable "system_vnet_subnet_id" {
  description = "The ID of the subnet in which to deploy the node pool"
  type        = string
}

variable "system_host_encryption_enabled" {
  description = "Enable host encryption"
  type        = bool
}

variable "system_only_critical_addons_enabled" {
  description = "Enable only critical addons"
  type        = bool
}

variable "system_temporary_name_for_rotation" {
  description = "Temporary name for rotation"
  type        = string
}

variable "system_node_labels" {
  description = "A mapping of labels to assign to the system node pool"
  type        = map(string)
}

# np_one Node Pool
variable "np_one_node_pool_name" {
  description = "The name of the np_one node pool"
  type        = string
}

variable "np_one_vm_size" {
  description = "The size of the Virtual Machines in the node pool"
  type        = string
}

variable "np_one_node_count" {
  description = "The number of nodes in the node pool"
  type        = number
}

variable "np_one_vnet_subnet_id" {
  description = "The ID of the subnet in which to deploy the node pool"
  type        = string
}

variable "np_one_host_encryption_enabled" {
  description = "Enable host encryption"
  type        = bool
}

variable "np_one_node_labels" {
  description = "A mapping of labels to assign to the np_one node pool"
  type        = map(string)
}

variable "tags" {
  description = "A mapping of tags to assign to the cluster resources"
  type        = map(string)
}