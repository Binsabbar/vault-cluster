// Usually, the roleId will be generated and delivered to an entity to use it
// The secretId will be generated on demand by another provider and delivered wrapped to the entity with ttl
// The entity will use the roleId it has + the wrapped SecretId to generate a login token

resource "vault_auth_backend" "approle" {
  type = "approle"
}

resource "vault_approle_auth_backend_role" "cicd" {
  backend            = vault_auth_backend.approle.path
  role_name          = "cicd"
  token_policies     = ["default", "admin"]
  
  # How many times can this secretId be used to fetch a token?
  secret_id_num_uses = 1 
  # secret_id_ttl = 100 # The time to live for the secret id before it is destoryed
}

resource "vault_identity_entity" "cicd_entity" {
  name     = "cicd"
}

resource "vault_identity_entity_alias" "cicd_entity_alias" {
  name           = vault_approle_auth_backend_role.cicd.role_name
  mount_accessor = vault_auth_backend.approle.accessor
  canonical_id = vault_identity_entity.cicd_entity.id
}