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