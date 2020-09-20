path "secret/data/apps/production/*" { 
  capabilities = ["read", "list"]
}

path "secret/metadata/apps/production/*" { 
  capabilities = ["list", "read"]
}

path "secret/data/infra/production/*" { 
  capabilities = ["read", "list"]
}

path "secret/metadata/infra/production/*" { 
  capabilities = ["list", "read"]
}