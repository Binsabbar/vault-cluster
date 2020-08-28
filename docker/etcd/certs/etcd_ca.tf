resource "tls_private_key" "etcd_ca_key" {
  algorithm = "RSA"
  rsa_bits  = 4048
}

locals {
  cert_period = 24 * 30 * 12
}
resource "tls_self_signed_cert" "etcd_ca_cert" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.etcd_ca_key.private_key_pem

  subject {
    common_name    = "etcd.local"
    organization   = "Mo's Inc"
    street_address = []
  }
  dns_names   = ["etcd.local", "etcd.internal"]
  validity_period_hours = local.cert_period
  is_ca_certificate = true
  allowed_uses = [
    "digital_signature",
    "crl_signing",
    "cert_signing",
  ]
}

resource "tls_locally_signed_cert" "etcd_node_cert" {
  for_each = local.etcd_nodes

  cert_request_pem = tls_cert_request.etcd_node_csr[each.key].cert_request_pem

  ca_key_algorithm   = tls_self_signed_cert.etcd_ca_cert.key_algorithm
  ca_private_key_pem = tls_private_key.etcd_ca_key.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.etcd_ca_cert.cert_pem

  validity_period_hours = local.cert_period

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "local_file" "etcd_ca_private_key" {
  content         = tls_private_key.etcd_ca_key.private_key_pem
  filename        = "${path.module}/etcd-ca-key.pem"
  file_permission = "0600"
}

resource "local_file" "etcd_ca_cert" {
  content         = tls_self_signed_cert.etcd_ca_cert.cert_pem
  filename        = "${path.module}/etcd-ca-cert.pem"
  file_permission = "0600"
}

resource "local_file" "etcd_node_cert" {
  for_each = local.etcd_nodes

  content         = "${tls_locally_signed_cert.etcd_node_cert[each.key].cert_pem}${tls_self_signed_cert.etcd_ca_cert.cert_pem}"
  filename        = "${path.module}/${each.key}-cert.pem"
  file_permission = "0600"
}