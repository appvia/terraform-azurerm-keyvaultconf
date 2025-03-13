# Azure KeyVault Terraform Module

This Terraform module creates an Azure Key Vault with optional resource group creation and managed identity access support.

## Features

* Creates an Azure Key Vault with RBAC authorization enabled
* Optionally creates a new resource group or uses an existing one
* Automatically names the KeyVault using a combination of the provided name and resource group name
* Creates a test secret using the provided noun and verb
* Configurable network access controls
* Support for managed identity access through Azure RBAC
* Automatically assigns Key Vault Administrator role to the deployment identity

## Usage

### Creating a Key Vault with a new resource group

```hcl
module "keyvault" {
  source  = "github.com/appvia/terraform-azurerm-keyvaultconf"
  
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
```

### Using an existing resource group

```hcl
module "keyvault" {
  source  = "github.com/appvia/terraform-azurerm-keyvaultconf"
  
  resource_group_name   = "existing-rg"
  create_resource_group = false
  name                  = "kv"
  
  secret_noun           = "dog"
  secret_verb           = "barks"
}
```

### More restricted network access

```hcl
module "keyvault" {
  source  = "github.com/appvia/terraform-azurerm-keyvaultconf"
  
  resource_group_name     = "existing-rg"
  create_resource_group   = false
  name                    = "kv"
  
  default_network_acl_action = "Deny"
  ip_allow_list             = ["123.123.123.123/32"]
  
  secret_noun = "fish"
  secret_verb = "swims"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| azurerm | >= 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | The name of the resource group where the Key Vault will be created | `string` | n/a | yes |
| create_resource_group | Whether to create a new resource group or use an existing one | `bool` | `false` | no |
| name | The base name component for the Key Vault (will be combined with resource group name) | `string` | n/a | yes |
| location | The Azure region where the resources will be created | `string` | `"westeurope"` | no |
| sku_name | The SKU name of the Key Vault (standard or premium) | `string` | `"standard"` | no |
| tags | A mapping of tags to assign to the resources | `map(string)` | `{}` | no |
| default_network_acl_action | The default action for network ACLs (Allow or Deny) | `string` | `"Allow"` | no |
| ip_allow_list | List of IP addresses or CIDR blocks that should be allowed to access the Key Vault | `list(string)` | `[]` | no |
| secret_noun | A noun to use in the test secret | `string` | `"dog"` | no |
| secret_verb | A verb to use in the test secret | `string` | `"barks"` | no |
| assign_deployer_admin_role | Whether to assign Key Vault Administrator role to the identity running the deployment | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| key_vault_id | The ID of the Key Vault |
| key_vault_uri | The URI of the Key Vault |
| key_vault_name | The name of the Key Vault |
| resource_group_id | The ID of the resource group |
| test_secret_id | The ID of the test secret |
| test_secret_version | The version of the test secret |
| test_secret_name | The name of the test secret |

## Managed Identity Access

This module enables RBAC authorization on the Key Vault, allowing any managed identity with appropriate Azure KeyVault role permissions on the resource group to access the vault without needing explicit access policies.

### Auto-assigned Roles

The module automatically assigns the following roles (unless disabled via `assign_deployer_admin_role = false`):
- **Key Vault Administrator** to the identity running the Terraform deployment (to allow secret creation/management)

### Other Roles for Managed Identities

Other roles that can be assigned to managed identities include:
- Key Vault Reader
- Key Vault Secrets User
- Key Vault Secrets Officer
- Key Vault Certificates Officer

### Deployment Identity Requirements

The identity running the Terraform deployment must have:
1. At least **Contributor** access to the subscription or resource group
2. Sufficient permissions to assign RBAC roles (typically **User Access Administrator** or similar)

If the identity running the deployment doesn't have permissions to assign roles, you'll need to manually assign the "Key Vault Administrator" role to enable successful secret creation.

## License

This module is licensed under the license found in the LICENSE file in the root directory of this repository.
