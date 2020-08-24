ui = true

listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = true
  api_addr = "http://0.0.0.0:8200"
  cluster_addr = "http://0.0.0.0:8201"
}
api_addr = "http://0.0.0.0:8200"

storage "file" {
  path = "/data/vault/"
}
