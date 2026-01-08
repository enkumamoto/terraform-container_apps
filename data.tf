data "azurerm_resource_group" "suxenregistrydev_rg" {
  name = "RG-Shared"
}

data "azurerm_container_registry" "suxenregistrydev" {
  name                = "suxenregistrydev"
  resource_group_name = var.shared_resource_group_name
}

data "azurerm_subnet" "strapi_sandbox_subnet" {
  name                 = "strapi-Sandbox-ContainerAppsSubnet"
  resource_group_name  = "RG-Shared"
  virtual_network_name = "strapi-devVnet"
}
