output "approles" {
  value = {
    "${vault_approle_auth_backend_role.cicd.role_name}" = {
      role_id = vault_approle_auth_backend_role.cicd.role_id
      path    = vault_auth_backend.approle.path
    }
  }
}
