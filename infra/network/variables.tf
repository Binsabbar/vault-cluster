variable "compartment_id" { type = string }
variable "allowed_ingress_ports" {
  type    = list(number)
  default = [80, 443]
}

variable "public_net_security_list_ids" {
  type    = list(string)
  default = []
}

variable "private_net_security_list_ids" {
  type    = list(string)
  default = []
}