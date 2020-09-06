output "groups" {
  value = {
    admins                      = vault_identity_group.admins
    default                     = vault_identity_group.default
    wrapped_secret_id_generator = vault_identity_group.wrapped_secret_id_generator
  }
}