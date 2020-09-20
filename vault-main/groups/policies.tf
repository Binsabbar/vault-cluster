resource "vault_policy" "admins" {
  name = "admins"

  policy = file("${path.module}/policies/admin.hcl")
}

resource "vault_policy" "wrapped_secret_id_generator" {
  name = "wrapped-secret-id-generator"

  policy = file("${path.module}/policies/wrapped-secret-generator.hcl")
}

resource "vault_policy" "dev_deployer" {
  name = "dev-deployer"

  policy = file("${path.module}/policies/dev-deployer.hcl")
}

resource "vault_policy" "uat_deployer" {
  name = "uat-deployer"

  policy = file("${path.module}/policies/uat-deployer.hcl")
}

resource "vault_policy" "prod_deployer" {
  name = "prod-deployer"

  policy = file("${path.module}/policies/prod-deployer.hcl")
}