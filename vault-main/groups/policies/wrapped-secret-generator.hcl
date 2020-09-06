// to be able to login
path "auth/approle/role/cicd_dev_deployer/secret-id" {
  capabilities = [ "create", "update", "list"]
}

path "auth/approle/role/cicd_uat_deployer/secret-id" {
  capabilities = [ "create", "update", "list"]
}

path "auth/approle/role/cicd_prod_deployer/secret-id" {
  capabilities = [ "create", "update", "list"]
}