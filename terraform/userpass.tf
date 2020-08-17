locals {
  admins = ["admin"]
}

resource "vault_auth_backend" "userpass" {
  type = "userpass"
}

resource "vault_identity_entity" "admin_entity" {
  for_each = toset(local.admins)
  name      = each.key
}

resource "vault_identity_entity_alias" "admins_entity_alias" {
  for_each = toset(local.admins)

  name            = each.key
  mount_accessor  = vault_auth_backend.userpass.accessor

  canonical_id    = vault_identity_entity.admin_entity[each.key].id
}


// creating user manually (not recomended)
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
