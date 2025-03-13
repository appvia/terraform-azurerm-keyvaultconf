variable "resource_group_name" {
  description = "The name of the resource group where the Key Vault will be created"
  type        = string
}

variable "create_resource_group" {
  description = "Whether to create a new resource group or use an existing one"
  type        = bool
  default     = false
}

variable "name" {
  description = "The base name component for the Key Vault (will be combined with resource group name)"
  type        = string
}

variable "location" {
  description = "The Azure region where the resources will be created"
  type        = string
  default     = "westeurope"
}

variable "sku_name" {
  description = "The SKU name of the Key Vault (standard or premium)"
  type        = string
  default     = "standard"
  
  validation {
    condition     = contains(["standard", "premium"], var.sku_name)
    error_message = "The SKU name must be either 'standard' or 'premium'."
  }
}

variable "tags" {
  description = "A mapping of tags to assign to the resources"
  type        = map(string)
  default     = {}
}

variable "default_network_acl_action" {
  description = "The default action for network ACLs (Allow or Deny)"
  type        = string
  default     = "Allow"
  
  validation {
    condition     = contains(["Allow", "Deny"], var.default_network_acl_action)
    error_message = "The default action must be either 'Allow' or 'Deny'."
  }
}

variable "ip_allow_list" {
  description = "List of IP addresses or CIDR blocks that should be allowed to access the Key Vault"
  type        = list(string)
  default     = []
}

variable "secret_noun" {
  description = "A noun to use in the test secret"
  type        = string
  default     = "dog"
}

variable "secret_verb" {
  description = "A verb to use in the test secret"
  type        = string
  default     = "barks"
}

variable "assign_deployer_admin_role" {
  description = "Whether to assign Key Vault Administrator role to the identity running the deployment"
  type        = bool
  default     = true
} 