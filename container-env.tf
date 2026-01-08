resource "azurerm_log_analytics_workspace" "loganalytics" {
  name                = "strapisandboxlogs"
  location            = var.location
  resource_group_name = var.shared_resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_container_app_environment" "strapi_container_app_env" {
  name                       = "ContainerAppSandboxEnvironment"
  location                   = var.location
  resource_group_name        = var.shared_resource_group_name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.loganalytics.id
  infrastructure_subnet_id   = data.azurerm_subnet.strapi_sandbox_subnet.id
}