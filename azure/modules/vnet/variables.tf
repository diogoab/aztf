variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "The address space for the virtual network"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group in which the virtual network will be created"
  type        = string
}

variable "location" {
  description = "The location/region of the virtual network"
  type        = string
}

variable "subnet1_name" {
  description = "The name of the subnet1"
  type        = string
}

variable "subnet1_address_prefix" {
  description = "The address prefix for the subnet1"
  type        = string
}

variable "subnet1_nsg_security_rules" {
  description = "The security rules for the subnet1"
  type = list(object({
    name                       = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    access                     = string
    priority                   = number
    direction                  = string
  }))
  default = null # Make this variable optional
}

variable "tags" {
  description = "A map of tags to assign to the network resources"
  type        = map(string)
}
