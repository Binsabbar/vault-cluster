// Usually, the roleId will be generated and delivered to an entity to use it
// The secretId will be generated on demand by another provider and delivered wrapped to the entity with ttl
// The entity will use the roleId it has + the wrapped SecretId to generate a login token

data "vault_auth_backend" "token" {
  path = "token"
}

resource "vault_auth_backend" "approle" {
  type = "approle"
}

resource "vault_identity_entity" "entity" {
  for_each = local.vault_entities
  name     = each.key
}

// AppRoles Memeberships
resource "vault_identity_group_member_entity_ids" "members_wrapped_secret_id_generator" {
  exclusive         = true
  member_entity_ids = [vault_identity_entity.entity["wrapped_secret_id_generator"].id]
  group_id          = var.groups.wrapped_secret_id_generator.id
}

// Create Roles
resource "vault_approle_auth_backend_role" "role" {
  for_each           = toset(local.backend_roles)
  backend            = vault_auth_backend.approle.path
  role_name          = each.key
  token_policies     = []
  secret_id_num_uses = 0
}

// Map Entity to A Role 
resource "vault_identity_entity_alias" "role_entity_alias" {
  for_each = { for alias in local.flattened_aliases : "${alias.entity}-${alias.role}" => alias }

  name           = vault_approle_auth_backend_role.role["${each.value.role}"].role_id
  mount_accessor = vault_auth_backend.approle.accessor
  canonical_id   = vault_identity_entity.entity["${each.value.entity}"].id
}

resource "vault_identity_entity_alias" "role_entity_alias_token" {
  for_each = { for alias in local.flattened_aliases : "${alias.entity}-${alias.role}" => alias }

  name           = vault_approle_auth_backend_role.role["${each.value.role}"].role_id
  mount_accessor = data.vault_auth_backend.token.accessor
  canonical_id   = vault_identity_entity.entity["${each.value.entity}"].id
}