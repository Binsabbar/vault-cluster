resource "vault_identity_group" "admins" {
  name     = "admins"
  type     = "internal"
  policies = [vault_policy.admins.name]
}

resource "vault_identity_group" "default" {
  name     = "default"
  type     = "internal"
  policies = ["default"]
}

resource "vault_identity_group" "secret_fetcher" {
  name     = "secret_fetcher"
  type     = "internal"
  policies = []
}

resource "vault_identity_group" "approle_token_generator" {
  name     = "approle_token_generator"
  type     = "internal"
  policies = []
}

resource "vault_identity_group" "development" {
  name     = "development"
  type     = "internal"
  policies = []
}

resource "vault_identity_group" "uat" {
  name     = "uat"
  type     = "internal"
  policies = []
}

resource "vault_identity_group" "production" {
  name     = "prod"
  type     = "internal"
  policies = []
}
