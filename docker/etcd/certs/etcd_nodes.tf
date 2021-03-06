locals {
  etcd_nodes = {
    "etcd-node-1" = {
      uris        = ["etcd-1.internal", "etcd.internal"]
      dns_names   = ["etcd-1.internal", "etcd.internal"]
      common_name = "etcd-1.internal"
    }

    "etcd-node-2" = {
      uris        = ["etcd-2.internal", "etcd.internal"]
      dns_names   = ["etcd-2.internal", "etcd.internal"]
      common_name = "etcd-2.internal"
    }

    "etcd-node-3" = {
      uris        = ["etcd-3.internal", "etcd.internal"]
      dns_names   = ["etcd-3.internal", "etcd.internal"]
      common_name = "etcd-3.internal"
    }

    "vault-client" = {
      uris        = ["vault.internal", "vault-1.internal", "vault-2.internal", "vault-3.internal"]
      dns_names   = ["vault.internal", "vault-1.internal", "vault-2.internal", "vault-3.internal"]
      common_name = "vault.internal"
    }
  }
}

resource "tls_private_key" "etcd_node_key" {
  for_each = local.etcd_nodes

  algorithm = "RSA"
  rsa_bits  = 4048
}

resource "tls_cert_request" "etcd_node_csr" {
  for_each = local.etcd_nodes

  key_algorithm   = tls_private_key.etcd_node_key[each.key].algorithm
  private_key_pem = tls_private_key.etcd_node_key[each.key].private_key_pem
  uris            = each.value.uris
  dns_names       = each.value.dns_names
  subject {
    common_name  = each.value.common_name
    organization = "Mo's Inc"
  }
}

resource "local_file" "etcd_node_key" {
  for_each = local.etcd_nodes

  content         = tls_private_key.etcd_node_key[each.key].private_key_pem
  filename        = "${path.module}/${each.key}-key.pem"
  file_permission = "0600"
}