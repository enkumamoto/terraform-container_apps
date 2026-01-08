variable "shared_resource_group_name" {
  type    = string
  default = "RG-Shared"
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "vnet_name" {
  type    = string
  default = "strapi-devVnet"
}

variable "tier_account" {
  type    = string
  default = "standard"
}

variable "replication_type" {
  type    = string
  default = "lrs"
}

variable "strapi_image" {
  type    = string
  default = "application/vnd.docker.distribution.manifest.v2+json"
}

variable "parent_id" {
  type    = string
  default = "azurerm_resource_group.RG-shared.id"
}

variable "managed_Environment_Id" {
  type    = string
  default = "azapi_resource.aca-strapi-teste.id"
}
variable "producer_image_name" {
  type    = string
  default = "suxen-strapi-cms"
}

variable "storage_account_name" {
  type    = string
  default = "suxenstrapiqa"
}

variable "storage_container" {
  type    = string
  default = "strapiqacontainer"
}

variable "container_app_name" {
  type    = string
  default = "strapisandbox"
}

variable "ingress_rule" {
  type = map(any)
  default = {
    100 = "80"
    102 = "443"
    103 = "1337"
  }
}

# variable "outbound_rule" {
#   type = map(any)
#   default = {
#     100 = "80"
#     102 = "443"
#     103 = "1337"
#   }
# }
