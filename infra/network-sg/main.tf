locals {
  protocols = {
    icmp = 1
    tcp  = 6
    udp  = 17
  }
}

// Public Subnet NSG
resource "oci_core_network_security_group" "public_subnet_nsg" {
  compartment_id = var.compartment.id
  vcn_id         = var.vnc.id
  display_name   = "SSH Access Rules"
}

resource "oci_core_network_security_group_security_rule" "ssh_from_safe_ips" {
  for_each                  = toset(var.safe_ips)
  network_security_group_id = oci_core_network_security_group.public_subnet_nsg.id
  direction                 = "INGRESS"
  protocol                  = local.protocols.tcp
  description               = "Ingress Rule for SSH Connections from IP ${each.value}"
  stateless                 = false
  source                    = each.value
  source_type               = "CIDR_BLOCK"

  tcp_options {
    destination_port_range {
      max = 22
      min = 22
    }
  }
}

resource "oci_core_network_security_group_security_rule" "vault_from_safe_ips" {
  for_each                  = toset(var.safe_ips)
  network_security_group_id = oci_core_network_security_group.public_subnet_nsg.id
  direction                 = "INGRESS"
  protocol                  = local.protocols.tcp
  description               = "Ingress Rule for SSH Connections from IP ${each.value}"
  stateless                 = false
  source                    = each.value
  source_type               = "CIDR_BLOCK"

  tcp_options {
    destination_port_range {
      max = 8200
      min = 8200
    }
  }
}

// Private Subnet NSG
resource "oci_core_network_security_group" "private_subnet_nsg" {
  compartment_id = var.compartment.id
  vcn_id         = var.vnc.id
  display_name   = "privateSubnetNSG"
}

resource "oci_core_network_security_group_security_rule" "allow_vnc_access" {
  network_security_group_id = oci_core_network_security_group.private_subnet_nsg.id
  description               = "Allow All"
  direction                 = "INGRESS"
  protocol                  = "all"
  source                    = var.vnc.cidr_block
  source_type               = "CIDR_BLOCK"
  stateless                 = false
}

// resource "oci_core_network_security_group_security_rule" "egress_private" {
//   network_security_group_id = oci_core_network_security_group.private_subnet_nsg.id
//   description               = "Allow All"
//   direction                 = "EGRESS"
//   protocol                  = "all"
//   destination               = "0.0.0.0/0"
//   destination_type          = "CIDR_BLOCK"
//   stateless                 = false
// }
