// Demo App Env secrets
path "secret/data/apps/demo/*" { 
  capabilities = ["read", "list"]
}

path "secret/metadata/apps/demo/*" { 
  capabilities = ["list", "read"]
}

// Stage App Env secrets
path "secret/data/apps/stage/*" { 
  capabilities = ["read", "list"]
}

path "secret/metadata/apps/stage/*" { 
  capabilities = ["list", "read"]
}

// Demo Infra secrets
path "secret/data/infra/demo/*" { 
  capabilities = ["read", "list"]
}

path "secret/metadata/infra/demo/*" { 
  capabilities = ["list", "read"]
}

// Stage Infra secrets
path "secret/data/infra/stage/*" { 
  capabilities = ["read", "list"]
}

path "secret/metadata/infra/stage/*" { 
  capabilities = ["list", "read"]
}