ui = true

listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = true
  api_addr = "https://0.0.0.0:8200"
  cluster_addr = "https://0.0.0.0:8201"
  tls_disable = false
  tls_cert_file = "/certs/vault-node-1-cert.pem"
  tls_key_file = "/certs/vault-node-1-key.pem"
}

api_addr = "http://0.0.0.0:8200"

storage "file" {
  path = "/data/vault/"
}
