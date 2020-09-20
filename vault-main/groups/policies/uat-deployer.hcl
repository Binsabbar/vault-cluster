path "secret/data/apps/uat/*" { 
  capabilities = ["read", "list"]
}

path "secret/metadata/apps/uat/*" { 
  capabilities = ["list", "read"]
}

path "secret/data/infra/uat/*" { 
  capabilities = ["read", "list"]
}

path "secret/metadata/infra/uat/*" { 
  capabilities = ["list", "read"]
}