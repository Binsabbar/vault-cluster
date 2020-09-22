// Demo secrets
path "secret/data/demo/*" { 
  capabilities = ["read", "list"]
}

path "secret/metadata/demo/*" { 
  capabilities = ["list", "read"]
}

// Stage secrets
path "secret/data/stage/*" { 
  capabilities = ["read", "list"]
}

path "secret/metadata/stage/*" { 
  capabilities = ["list", "read"]
}