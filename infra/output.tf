output "instances" {
  value = module.instances.instances
}

output "lb" {
  value = {
    private = module.private_loadbalancer.lb.ip_addresses
    public = module.public_loadbalancer.lb.ip_addresses
  }
}