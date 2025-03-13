output "keyvault1_id" {
  description = "The ID of the first Key Vault"
  value       = module.keyvault_with_new_rg.key_vault_id
}

output "keyvault1_uri" {
  description = "The URI of the first Key Vault"
  value       = module.keyvault_with_new_rg.key_vault_uri
}

output "keyvault1_secret" {
  description = "The test secret details of the first Key Vault"
  value = {
    name    = module.keyvault_with_new_rg.test_secret_name
    id      = module.keyvault_with_new_rg.test_secret_id
    version = module.keyvault_with_new_rg.test_secret_version
  }
  sensitive = true
}

output "keyvault2_id" {
  description = "The ID of the second Key Vault"
  value       = module.keyvault_with_existing_rg.key_vault_id
}

output "keyvault2_uri" {
  description = "The URI of the second Key Vault"
  value       = module.keyvault_with_existing_rg.key_vault_uri
}

output "keyvault2_secret" {
  description = "The test secret details of the second Key Vault"
  value = {
    name    = module.keyvault_with_existing_rg.test_secret_name
    id      = module.keyvault_with_existing_rg.test_secret_id
    version = module.keyvault_with_existing_rg.test_secret_version
  }
  sensitive = true
} 