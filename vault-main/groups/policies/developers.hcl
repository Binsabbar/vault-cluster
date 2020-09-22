// Demo secrets
path "secret/data/demo/apps/*" { 
  capabilities = ["create", "update", "delete", "read", "list"]
}

path "secret/metadata/demo/apps/*" { 
  capabilities = ["create", "update", "delete", "list", "read"]
}

// Stage secrets
path "secret/data/stage/apps/*" { 
  capabilities = ["create", "update", "delete", "read", "list"]
}

path "secret/metadata/stage/apps/*" { 
  capabilities = ["create", "update", "delete", "list", "read"]
}