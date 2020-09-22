output "groups" {
  value = {
    admins                      = vault_identity_group.admins
    default                     = vault_identity_group.default
    wrapped_secret_id_generator = vault_identity_group.wrapped_secret_id_generator
    development                 = vault_identity_group.development
    uat                         = vault_identity_group.uat
    production                  = vault_identity_group.production
    developers                  = vault_identity_group.developers
    dev_devops                  = vault_identity_group.dev_devops
  }
}