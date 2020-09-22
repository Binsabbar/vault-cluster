path "secret/data/production/apps/*" { 
  capabilities = ["read", "list"]
}

path "secret/metadata/production/apps/*" { 
  capabilities = ["list", "read"]
}

path "secret/data/production/infra/*" { 
  capabilities = ["read", "list"]
}

path "secret/metadata/production/infra/*" { 
  capabilities = ["list", "read"]
}