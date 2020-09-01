provider "vault" {
  address      = var.address
  token        = var.token
  ca_cert_file = var.ca_cert_file
}

resource "vault_approle_auth_backend_role_secret_id" "secret_id" {
  for_each = toset(var.role_ids)

  backend   = var.backend_path
  role_name = each.key
  wrapping_ttl = 60 # in seconds
}