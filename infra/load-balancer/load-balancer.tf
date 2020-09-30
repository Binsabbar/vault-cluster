resource "oci_load_balancer_load_balancer" "load_balancer" {
  compartment_id             = var.compartment.id
  display_name               = var.name
  subnet_ids                 = var.subnet_ids
  shape                      = var.shape
  is_private                 = var.is_private
  network_security_group_ids = var.security_group_ids
}
