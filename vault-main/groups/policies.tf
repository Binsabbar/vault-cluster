resource "vault_policy" "admins" {
  name = "admins"

  policy = file("${path.module}/policies/admin.hcl")
}

resource "vault_policy" "wrapped_secret_id_generator" {
  name = "wrapped-secret-id-generator"

  policy = file("${path.module}/policies/wrapped-secret-generator.hcl")
}