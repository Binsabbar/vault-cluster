locals {
  private_lb_configurations = {
    "etcd-backend-set" = {
      virtual_hosts = ["etcd.private.vaultvnc.oraclevcn.com"]
      port          = 2379
      backends = [
        {
          ip   = module.instances.instances.etcd-1.private_ip
          port = 2379
        },
        {
          ip   = module.instances.instances.etcd-2.private_ip
          port = 2379
        },
        {
          ip   = module.instances.instances.etcd-3.private_ip
          port = 2379
        }
      ]
    }
  }
}