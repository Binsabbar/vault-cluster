# Enable key/value secrets engine at the secret/* paths
path "sys/mounts/*" {
	capabilities = [ "create", "update", "read", "delete", "list"]
}

# To list the available secrets engines
path "sys/mounts" {
  capabilities = [ "read" ]
}

# List existing policies
path "sys/policies/acl" {
  capabilities = ["list"]
}
# Create policies to permit apps to read secrets
path "sys/policies/acl/*" {
  capabilities = [ "create", "read", "update", "delete", "list" ]
}

# Mount auth methods
path "sys/auth" {
  capabilities = ["read"]
}
path "sys/auth/*" {
  capabilities = [ "create", "read", "update", "delete", "sudo" ]
}


# Write and manage secrets in key/value secrets engine
path "secret/*" {
	capabilities = [ "create", "update", "read", "delete", "list"]
}

# Configure and manage all auth methods accross vault
path "auth/*" {
  capabilities = [ "create", "read", "update", "delete", "list", "sudo" ]
}

# Create tokens
path "auth/token/create" {
  capabilities = ["create", "update"]
}


path "sys/seal" {
	capabilities = ["create", "update", "sudo"]
}

path "sys/unseal" {
	capabilities = ["create", "update", "sudo"]
}