output "key_vault_id" {
  description = "The ID of the Key Vault"
  value       = azurerm_key_vault.this.id
}

output "key_vault_uri" {
  description = "The URI of the Key Vault"
  value       = azurerm_key_vault.this.vault_uri
}

output "key_vault_name" {
  description = "The name of the Key Vault"
  value       = azurerm_key_vault.this.name
}

output "resource_group_id" {
  description = "The ID of the resource group"
  value       = var.create_resource_group ? azurerm_resource_group.this[0].id : data.azurerm_resource_group.existing[0].id
}

output "test_secret_id" {
  description = "The ID of the test secret"
  value       = azurerm_key_vault_secret.test_secret.id
}

output "test_secret_version" {
  description = "The version of the test secret"
  value       = azurerm_key_vault_secret.test_secret.version
}

output "test_secret_name" {
  description = "The name of the test secret"
  value       = azurerm_key_vault_secret.test_secret.name
} 