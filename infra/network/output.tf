output "network" {
  value = {
    "vnc"            = oci_core_vcn.vnc
    "public_subnet"  = oci_core_subnet.public_subnet
    "private_subnet" = oci_core_subnet.private_subnet
  }
}
