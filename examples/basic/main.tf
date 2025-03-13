provider "azurerm" {
  features {}
}

# Example 1: Creating a Key Vault with a new resource group
module "keyvault_with_new_rg" {
  source = "../../"
  
  resource_group_name  = "kv-example-rg"
  create_resource_group = true
  name                 = "kv"
  location             = "westeurope"
  
  secret_noun          = "cat"
  secret_verb          = "meows"
  
  tags = {
    environment = "dev"
    project     = "demo"
  }
}

# Example 2: Creating a Key Vault using an existing resource group
module "keyvault_with_existing_rg" {
  source = "../../"
  
  resource_group_name   = "existing-rg"
  create_resource_group = false
  name                  = "kv2"
  
  # More restrictive network settings
  default_network_acl_action = "Deny"
  ip_allow_list             = ["123.123.123.123/32"]
  
  secret_noun = "fish"
  secret_verb = "swims"
}

# Example 3: Assign custom RBAC roles to a managed identity
# This assumes you have a managed identity already created
data "azurerm_user_assigned_identity" "example_identity" {
  name                = "example-identity"
  resource_group_name = "identity-rg"
  count               = 0  # Set to 1 if you have a real identity to reference
}

# Optionally assign Key Vault Secrets User role to a managed identity
# This allows the identity to read but not modify secrets
resource "azurerm_role_assignment" "identity_secrets_user" {
  count                = 0  # Set to 1 if you have a real identity to assign
  scope                = module.keyvault_with_new_rg.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = data.azurerm_user_assigned_identity.example_identity[0].principal_id
} 