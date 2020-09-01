output "approles" {
  value = {
    for k, v in vault_approle_auth_backend_role.role :
    "${k}" => {
      role_id   = v.role_id
      role_name = k
      path      = vault_auth_backend.approle.path
    }
  }
}


output "entities" {
  value = {
    for k in keys(local.vault_entities) : k => k
  }
}