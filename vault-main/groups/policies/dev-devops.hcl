// Demo secrets
path "secret/data/demo/*" { 
  capabilities = ["create", "update", "delete", "read", "list"]
}

path "secret/metadata/demo/*" { 
  capabilities = ["create", "update", "delete", "list", "read"]
}

// Stage secrets
path "secret/data/stage/*" { 
  capabilities = ["create", "update", "delete", "read", "list"]
}

path "secret/metadata/stage/*" { 
  capabilities = ["create", "update", "delete", "list", "read"]
}