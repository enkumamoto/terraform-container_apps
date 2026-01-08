resource "azurerm_container_app" "strapi_container_app" {
  name                         = var.container_app_name
  container_app_environment_id = azurerm_container_app_environment.strapi_container_app_env.id
  resource_group_name          = var.shared_resource_group_name
  revision_mode                = "Single"

  registry {
    server               = data.azurerm_container_registry.suxenregistrydev.login_server
    username             = data.azurerm_container_registry.suxenregistrydev.admin_username
    password_secret_name = "registrypassword"
  }

  secret {
    name  = "registrypassword"
    value = data.azurerm_container_registry.suxenregistrydev.admin_password
  }

  ingress {
    external_enabled = true
    target_port      = 1337
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  template {
    container {
      name   = "strapi-sandbox"
      image  = "${data.azurerm_container_registry.suxenregistrydev.login_server}/suxen-strapi-cms:latest"
      cpu    = 0.25
      memory = "0.5Gi"

      env {
        name  = "ADMIN_JWT_SECRET"
        value = "xxxx"
      }
      env {
        name  = "API_TOKEN_SALT"
        value = "xxxx"
      }
      env {
        name  = "APP_KEYS"
        value = "xxxx"
      }
      env {
        name  = "DATABASE_CLIENT"
        value = "postgres"
      }
      env {
        name  = "DATABASE_HOST"
        value = "strapi-cdci-server.postgres.database.azure.com"
      }
      env {
        name  = "DATABASE_NAME"
        value = "strapi-dev-database"
      }
      env {
        name  = "DATABASE_PASSWORD"
        value = "xxx"
      }
      env {
        name  = "DATABASE_PORT"
        value = "5432"
      }
      env {
        name  = "DATABASE_SSL"
        value = "true"
      }
      env {
        name  = "DATABASE_USERNAME"
        value = "xxx"
      }
      env {
        name  = "JWT_SECRET"
        value = "xxx"
      }
      env {
        name  = "PORT"
        value = "1337"
      }
      env {
        name  = "STORAGE_ACCOUNT"
        value = "suxenstrapiqa"
      }
      env {
        name  = "STORAGE_ACCOUNT_KEY"
        value = "xxx"
      }
      env {
        name  = "STORAGE_CONTAINER_NAME"
        value = "strapiqacontainer"
      }
      env {
        name  = "STORAGE_URL"
        value = "xxxx"
      }
      env {
        name  = "TRANSFER_TOKEN_SALT"
        value = "xxxx"
      }
    }
  }
}
