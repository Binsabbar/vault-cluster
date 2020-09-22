locals {
  admins_usernames     = ["binsabbar"]
  developers_usernames = ["john", "sara"]
  dev_devops_usernames = ["mike", "kate"]
}

resource "vault_auth_backend" "userpass" {
  type = "userpass"
}

// Link userpass to an enttiy then to a group
// admins
resource "vault_identity_entity" "admin_entity" {
  for_each = toset(local.admins_usernames)
  name     = each.key
}

resource "vault_identity_entity_alias" "admins_entity_alias" {
  for_each       = toset(local.admins_usernames)
  name           = each.key
  mount_accessor = vault_auth_backend.userpass.accessor
  canonical_id   = vault_identity_entity.admin_entity[each.key].id
}

resource "vault_identity_group_member_entity_ids" "members_admins" {
  exclusive         = true
  member_entity_ids = [for admin in vault_identity_entity.admin_entity : admin.id]
  group_id          = var.groups.admins.id
}

// developers
resource "vault_identity_entity" "developers_entity" {
  for_each = toset(local.developers_usernames)
  name     = each.key
}

resource "vault_identity_entity_alias" "developers_entity_alias" {
  for_each       = toset(local.developers_usernames)
  name           = each.key
  mount_accessor = vault_auth_backend.userpass.accessor
  canonical_id   = vault_identity_entity.developers_entity[each.key].id
}

resource "vault_identity_group_member_entity_ids" "members_developers" {
  exclusive         = true
  member_entity_ids = [for developer in vault_identity_entity.developers_entity : developer.id]
  group_id          = var.groups.developers.id
}

// dev_devops
resource "vault_identity_entity" "dev_devops_entity" {
  for_each = toset(local.dev_devops_usernames)
  name     = each.key
}

resource "vault_identity_entity_alias" "dev_devopss_entity_alias" {
  for_each       = toset(local.dev_devops_usernames)
  name           = each.key
  mount_accessor = vault_auth_backend.userpass.accessor
  canonical_id   = vault_identity_entity.dev_devops_entity[each.key].id
}

resource "vault_identity_group_member_entity_ids" "members_dev_devops" {
  exclusive         = true
  member_entity_ids = [for dev_devops in vault_identity_entity.dev_devops_entity : dev_devops.id]
  group_id          = var.groups.dev_devops.id
}

/*******************************************************************************/
// creating user manually (not recomended) it exposes username and password in 
// the state and in the file. Suggestion would be to pass passwords via file to 
// Terraform, but still, how are you going to secure the passwords file?
# resource "vault_generic_endpoint" "admin" {
#   depends_on           = [vault_auth_backend.userpass]
#   path                 = "auth/userpass/users/admin"
#   ignore_absent_fields = true

#   data_json = <<EOT
#   {
#     "password": "changeme"
#   }
# EOT
# }
/*******************************************************************************/