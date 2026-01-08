```markdown
# Terraform: Azure Container App para Strapi

Este projeto Terraform provisiona uma infraestrutura na Azure para executar uma aplicação Strapi CMS em um Azure Container App.

## Arquitetura

O projeto cria os seguintes recursos na Azure:

- **Azure Container App**: Executa a aplicação Strapi
- **Container App Environment**: Ambiente gerenciado para containers
- **Log Analytics Workspace**: Monitoramento e logs da aplicação
- **Network Security Group**: Regras de segurança de rede
- **Subnet dedicada**: Rede isolada para os containers

## Arquivos de Configuração

### 1. `main.tf`
- Configuração do provider Terraform AzureRM
- Versões do provider e do Terraform

### 2. `variables.tf`
- Variáveis de configuração do projeto
- Regras de entrada/saída de rede
- Configurações de nome, localização e recursos

### 3. `data.tf`
- Data sources para recursos Azure existentes:
  - Resource Group
  - Container Registry
  - Subnet para Container Apps

### 4. `container-env.tf`
- Cria o Log Analytics Workspace
- Cria o Container App Environment
- Conecta o ambiente ao workspace de logs

### 5. `container-app.tf`
- Define a Container App principal
- Configura:
  - Imagem do container (Strapi CMS)
  - Variáveis de ambiente
  - Configurações de recursos (CPU, memória)
  - Ingress público na porta 1337
  - Registro no Container Registry

### 6. `nsg.tf`
- Cria Network Security Group
- Define regras de entrada (ingress)
- Regras de saída comentadas (para referência)

## Requisitos

- **Terraform**: versão >= 1.5.0
- **Azure CLI**: Autenticação configurada
- **Azure Subscription**: Com permissões adequadas
- **Container Registry**: Existente com imagem Strapi

## Recursos Azure Pré-existentes

Este projeto assume que os seguintes recursos já existem:
1. Resource Group: `RG-Shared`
2. Container Registry: `suxenregistrydev`
3. Virtual Network: `strapi-devVnet`
4. Subnet: `strapi-Sandbox-ContainerAppsSubnet`

## Variáveis de Ambiente Strapi

A aplicação Strapi requer as seguintes variáveis de ambiente (definidas em `container-app.tf`):

| Variável | Descrição |
|----------|-----------|
| `DATABASE_*` | Configuração do PostgreSQL |
| `ADMIN_JWT_SECRET` | Segredo para JWT do admin |
| `API_TOKEN_SALT` | Salt para tokens da API |
| `APP_KEYS` | Chaves da aplicação |
| `STORAGE_*` | Configuração do Azure Storage |

## Inicialização e Uso

```bash
# Inicializar o Terraform
terraform init

# Verificar o plano de execução
terraform plan

# Aplicar a configuração
terraform apply

# Destruir os recursos
terraform destroy
```

## Configuração de Rede

### Regras de Entrada Habilitadas:
- Porta 80 (HTTP)
- Porta 443 (HTTPS)
- Porta 1337 (Strapi)

### Regras de Saída:
- Atualmente comentadas (permitindo tráfego de saída padrão)

## Segurança

⚠️ **Avisos de Segurança**:

1. **Secrets em plaintext**: As senhas no arquivo `container-app.tf` estão visíveis
   - **Recomendação**: Usar Azure Key Vault ou variáveis de ambiente seguras

2. **Regras de NSG permissivas**:
   - `source_address_prefix = "*"` permite acesso de qualquer IP
   - **Recomendação**: Restringir a IPs específicos

3. **Imagem `latest` tag**: Usar versões específicas em produção

## Melhorias Sugeridas

1. **Gerenciamento de Secrets**:
   ```hcl
   data "azurerm_key_vault_secret" "database_password" {
     name = "strapi-db-password"
     key_vault_id = azurerm_key_vault.main.id
   }
   ```

2. **Tags de Recursos**:
   ```hcl
   tags = {
     Environment = "Sandbox"
     Application = "Strapi"
     ManagedBy = "Terraform"
   }
   ```

3. **Outputs úteis**:
   ```hcl
   output "container_app_url" {
     value = azurerm_container_app.strapi_container_app.ingress[0].fqdn
   }
   ```

## Monitoramento

- Logs disponíveis no Log Analytics Workspace
- Métricas através do Azure Monitor
- Health probes configurados automaticamente

## Limpeza

Para remover todos os recursos:
```bash
terraform destroy
```

## Suporte

Para problemas ou dúvidas, verifique:
1. Permissões do Service Principal/Azure CLI
2. Quotas de recursos na Azure
3. Conectividade de rede
4. Status do Container Registry

---
