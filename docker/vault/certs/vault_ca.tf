resource "tls_private_key" "vault_ca_key" {
  algorithm = "RSA"
  rsa_bits  = 4048
}

locals {
  cert_period = 24 * 30 * 12
}
resource "tls_self_signed_cert" "vault_ca_cert" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.vault_ca_key.private_key_pem

  subject {
    common_name    = "vault.internal"
    organization   = "Mo's Inc"
    street_address = []
  }

  validity_period_hours = local.cert_period

  allowed_uses = [
    "digital_signature",
    "crl_signing",
    "cert_signing"
  ]
}

resource "tls_locally_signed_cert" "vault_node_cert" {
  for_each = local.vault_nodes

  cert_request_pem = tls_cert_request.vault_node_csr[each.key].cert_request_pem

  ca_key_algorithm   = tls_self_signed_cert.vault_ca_cert.key_algorithm
  ca_private_key_pem = tls_private_key.vault_ca_key.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.vault_ca_cert.cert_pem

  validity_period_hours = local.cert_period

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
    "client_auth",
    "signing"
  ]
}

resource "local_file" "vault_ca_private_key" {
  content         = tls_private_key.vault_ca_key.private_key_pem
  filename        = "${path.module}/vault-ca-key.pem"
  file_permission = "0600"
}

resource "local_file" "vault_ca_cert" {
  content         = tls_self_signed_cert.vault_ca_cert.cert_pem
  filename        = "${path.module}/vault-ca-cert.pem"
  file_permission = "0600"
}

resource "local_file" "vault_node_cert" {
  for_each = local.vault_nodes

  content         = "${tls_locally_signed_cert.vault_node_cert[each.key].cert_pem}${tls_self_signed_cert.vault_ca_cert.cert_pem}"
  filename        = "${path.module}/${each.key}-cert.pem"
  file_permission = "0600"
}