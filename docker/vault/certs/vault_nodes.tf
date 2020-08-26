locals {
  vault_nodes = {
    "vault-node-1" = {
      uris        = ["vault-1"]
      dns_names   = ["vault-1.localhost"]
      common_name = "vault-1"
    }

    "vault-node-2" = {
      uris        = ["vault-2"]
      dns_names   = ["vault-2.localhost"]
      common_name = "vault-2"
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