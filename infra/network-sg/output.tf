output "nsg" {
  value = {
    public_subnet_nsg  = oci_core_network_security_group.public_subnet_nsg
    private_subnet_nsg = oci_core_network_security_group.private_subnet_nsg
  }
}
