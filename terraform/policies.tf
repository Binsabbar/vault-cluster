resource "vault_policy" "admins" {
  name = "admins"

  policy = file("./policies/admin.hcl")
}
