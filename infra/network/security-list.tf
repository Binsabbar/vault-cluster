locals {
  protocols = {
    icmp = 1
    tcp  = 6
    udp  = 17
  }
}

resource "oci_core_default_security_list" "security_list" {
  manage_default_resource_id = oci_core_vcn.vnc.default_security_list_id
  display_name               = "defaultSecurityList"

  dynamic "ingress_security_rules" {
    for_each = var.allowed_ingress_ports
    content {
      protocol    = local.protocols.tcp
      description = "Inbound for port ${ingress_security_rules.value} from any"
      source      = "0.0.0.0/0"
      stateless   = false

      tcp_options {
        min = ingress_security_rules.value
        max = ingress_security_rules.value
      }
    }
  }

  ingress_security_rules {
    protocol  = local.protocols.icmp
    source    = "0.0.0.0/0"
    stateless = true

    icmp_options {
      type = 3
      code = 4
    }
  }

  # Todo: It is not good practice to not open up egress completely like this
  egress_security_rules {
    destination = "0.0.0.0/0"
    description = "Outbound All TCP"
    protocol    = local.protocols.tcp
  }

  egress_security_rules {
    destination = "0.0.0.0/0"
    description = "Outbound All TCP"
    protocol    = local.protocols.udp
  }
}
