path "secret/data/uat/apps/*" { 
  capabilities = ["read", "list"]
}

path "secret/metadata/uat/apps/*" { 
  capabilities = ["list", "read"]
}

path "secret/data/uat/infra/*" { 
  capabilities = ["read", "list"]
}

path "secret/metadata/uat/infra/*" { 
  capabilities = ["list", "read"]
}