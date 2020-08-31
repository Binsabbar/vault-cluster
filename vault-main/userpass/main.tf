locals {
  admins_usernames = ["admin"]
}

resource "vault_auth_backend" "userpass" {
  type = "userpass"
}

// Start: Link userpass to an enttiy
resource "vault_identity_entity" "admin_entity" {
  for_each = toset(local.admins_usernames)
  name     = each.key
}

resource "vault_identity_entity_alias" "admins_entity_alias" {
  for_each = toset(local.admins_usernames)

  name           = each.key
  mount_accessor = vault_auth_backend.userpass.accessor

  canonical_id = vault_identity_entity.admin_entity[each.key].id
}
// End: Link userpass to an enttiy





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