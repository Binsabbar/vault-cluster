output "groups" {
  value = {
    admins  = vault_identity_group.admins
    default = vault_identity_group.default
  }
}