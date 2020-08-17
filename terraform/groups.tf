resource "vault_identity_group" "admins" {
  name     = "admins"
  type     = "internal"
  policies = ["admin"]
  member_entity_ids = flatten([for k in vault_identity_entity.admin_entity: [k.id]])
  metadata = {
    version = "1"
  }
}

resource "vault_identity_group" "default" {
  name     = "default"
  type     = "internal"
  policies = ["default"]
  member_entity_ids = []
  metadata = {
    version = "1"
  }
}