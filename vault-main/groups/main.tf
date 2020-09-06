resource "vault_identity_group" "admins" {
  name     = "admins"
  type     = "internal"
  policies = [vault_policy.admins.name]

  lifecycle {
    ignore_changes = [member_entity_ids]
  }
}

resource "vault_identity_group" "default" {
  name     = "default"
  type     = "internal"
  policies = ["default"]

  lifecycle {
    ignore_changes = [member_entity_ids]
  }
}

resource "vault_identity_group" "wrapped_secret_id_generator" {
  name     = "wrapped_secret_id_generator"
  type     = "internal"
  policies = [vault_policy.wrapped_secret_id_generator.name]

  lifecycle {
    ignore_changes = [member_entity_ids]
  }
}

resource "vault_identity_group" "development" {
  name     = "development"
  type     = "internal"
  policies = []

  lifecycle {
    ignore_changes = [member_entity_ids]
  }
}

resource "vault_identity_group" "uat" {
  name     = "uat"
  type     = "internal"
  policies = []

  lifecycle {
    ignore_changes = [member_entity_ids]
  }
}

resource "vault_identity_group" "production" {
  name     = "prod"
  type     = "internal"
  policies = []

  lifecycle {
    ignore_changes = [member_entity_ids]
  }
}
