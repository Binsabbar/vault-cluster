variable role_ids {
  type = list(string)
}
variable backend_path {
  type = string
}
variable token {
  type = string
}
variable address {
  type = string
}
variable ca_cert_file {
  type = string
}
variable wrapping_ttl {
  type = number
  default = 60 # in seconds
}
