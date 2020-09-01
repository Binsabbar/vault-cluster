output "approles" {
  value = {
    for k, v in vault_approle_auth_backend_role_secret_id.secret_id:
      "${v.role_name}" => v.secret_id
  }
}