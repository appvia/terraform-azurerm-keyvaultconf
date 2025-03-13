locals {
  # Create a consistent keyvault name based on resource group and provided name
  keyvault_name = "${var.name}-${var.resource_group_name}"
}

# Optionally create a resource group if var.create_resource_group is true
resource "azurerm_resource_group" "this" {
  count    = var.create_resource_group ? 1 : 0
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

data "azurerm_resource_group" "existing" {
  count = var.create_resource_group ? 0 : 1
  name  = var.resource_group_name
}

# Get current user for access policies
data "azurerm_client_config" "current" {}

# Create Key Vault
resource "azurerm_key_vault" "this" {
  name                = local.keyvault_name
  location            = var.create_resource_group ? azurerm_resource_group.this[0].location : data.azurerm_resource_group.existing[0].location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.sku_name

  # Enable RBAC for managed identities
  enable_rbac_authorization = true
  
  # Default network ACLs - can be overridden through variables
  network_acls {
    default_action = var.default_network_acl_action
    bypass         = "AzureServices"
    ip_rules       = var.ip_allow_list
  }

  # Create a secret for testing
  tags = var.tags
}

# Add the deploy-time test secret
resource "azurerm_key_vault_secret" "test_secret" {
  name         = "test-secret"
  value        = "${var.secret_noun}-${var.secret_verb}"
  key_vault_id = azurerm_key_vault.this.id
  
  depends_on = [
    azurerm_key_vault.this
  ]
} 