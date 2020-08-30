locals {
  vault_nodes = {
    "vault-node-1" = {
      uris        = ["vault.internal", "vault-1.internal"]
      dns_names   = ["vault.internal", "vault-1.internal"]
      common_name = "vault.internal"
    }
  }
}

resource "tls_private_key" "vault_node_key" {
  for_each = local.vault_nodes

  algorithm = "RSA"
  rsa_bits  = 4048
}

resource "tls_cert_request" "vault_node_csr" {
  for_each = local.vault_nodes

  key_algorithm   = tls_private_key.vault_node_key[each.key].algorithm
  private_key_pem = tls_private_key.vault_node_key[each.key].private_key_pem
  uris            = each.value.uris
  dns_names       = each.value.dns_names
  subject {
    common_name  = each.value.common_name
    organization = "Mo's Inc"
  }
}

resource "local_file" "vault_node_key" {
  for_each = local.vault_nodes

  content         = tls_private_key.vault_node_key[each.key].private_key_pem
  filename        = "${path.module}/${each.key}-key.pem"
  file_permission = "0600"
}