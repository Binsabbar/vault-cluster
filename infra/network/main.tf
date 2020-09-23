resource "oci_core_vcn" "vnc" {
  cidr_block     = "192.168.0.0/16"
  compartment_id = var.compartment_id
  display_name   = "VaultInCloudVnc"
  dns_label      = "vaultvnc"
}

resource "oci_core_default_dhcp_options" "dhcp_options" {
  manage_default_resource_id = oci_core_vcn.vnc.default_dhcp_options_id
  options {
    type        = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }
}

// Gateways
resource "oci_core_internet_gateway" "internet_gateway" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.vnc.id
  enabled        = true
  display_name   = "defaultInternetGateway"
}

resource "oci_core_nat_gateway" "nat_gateway" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.vnc.id
  display_name   = "defaultNatGateway"
}


// Routes
resource "oci_core_default_route_table" "public_route_table" {
  manage_default_resource_id = oci_core_vcn.vnc.default_route_table_id
  display_name               = "defaultRouteTable"
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.internet_gateway.id
  }
}

resource "oci_core_route_table" "private_route_table" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.vnc.id
  display_name   = "defaultPrivateRouteTable"
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.nat_gateway.id
  }
}

// Subnetting
resource "oci_core_subnet" "public_subnet" {
  compartment_id             = var.compartment_id
  cidr_block                 = "192.168.1.0/24"
  prohibit_public_ip_on_vnic = false
  vcn_id                     = oci_core_vcn.vnc.id
  dhcp_options_id            = oci_core_default_dhcp_options.dhcp_options.id
  route_table_id             = oci_core_default_route_table.public_route_table.id
  dns_label                  = "public"
  display_name               = "publicSubnet"
  security_list_ids          = concat([oci_core_default_security_list.public_subnet_security_list.id], var.public_net_security_list_ids)
}

resource "oci_core_subnet" "private_subnet" {
  compartment_id             = var.compartment_id
  cidr_block                 = "192.168.100.0/24"
  prohibit_public_ip_on_vnic = true
  vcn_id                     = oci_core_vcn.vnc.id
  dhcp_options_id            = oci_core_default_dhcp_options.dhcp_options.id
  route_table_id             = oci_core_route_table.private_route_table.id
  security_list_ids          = concat([oci_core_security_list.private_subnet_security_list.id], var.private_net_security_list_ids)
  dns_label                  = "private"
  display_name               = "privateSubnet"
}
