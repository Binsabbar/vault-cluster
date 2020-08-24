// Usually, the roleId will be generated and delivered to an entity to use it
// The secretId will be generated on demand by another provider and delivered wrapped to the entity with ttl
// The entity will use the roleId it has + the wrapped SecretId to generate a login token

resource "vault_auth_backend" "approle" {
  type = "approle"
}

resource "vault_approle_auth_backend_role" "cicd" {
  backend        = vault_auth_backend.approle.path
  role_name      = "cicd"
  token_policies = ["default", "admin"]
  secret_id_num_uses  = 1 # How many times can this secretId be used to fetch a token?
  # secret_id_ttl = 100 # The time to live for the secret id before it is destoryed
}

resource "vault_approle_auth_backend_role_secret_id" "dev_id" {
  backend      = vault_auth_backend.approle.path
  role_name    = vault_approle_auth_backend_role.cicd.role_name
  # wrapping_ttl = 60
}

resource "vault_approle_auth_backend_role_secret_id" "uat_id" {
  backend      = vault_auth_backend.approle.path
  role_name    = vault_approle_auth_backend_role.cicd.role_name
  # wrapping_ttl = 60
}


output "approles" {
  value = {
    "${vault_approle_auth_backend_role.cicd.role_name}" = {
      role_id = vault_approle_auth_backend_role.cicd.role_id
      path    = vault_auth_backend.approle.path
      secret_ids = {
        dev_id = vault_approle_auth_backend_role_secret_id.dev_id.secret_id 
        uat_id = vault_approle_auth_backend_role_secret_id.uat_id.secret_id 
      }
    }
  }
}
