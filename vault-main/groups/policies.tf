resource "vault_policy" "admins" {
  name = "admins"

  policy = file("${path.module}/policies/admin.hcl")
}
