ui = true

listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = true
  tls_disable = false
  tls_cert_file = "/certs/vault-node-1-cert.pem"
  tls_key_file = "/certs/vault-node-1-key.pem"
  tls_client_ca_file = "/certs/vault-ca-cert.pem"
}

api_addr = "https://vault.internal:8200"

storage "etcd" {
  address  = "https://etcd.internal:2379"
  etcd_api = "v3"
  tls_ca_file = "/certs/etcd-ca-cert.pem"
  tls_cert_file = "/certs/vault-client-cert.pem"
  tls_key_file = "/certs/vault-client-key.pem"
  ha_enabled = true
}
