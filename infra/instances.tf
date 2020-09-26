locals {
  instanceState = {
    RUNNING = "RUNNING"
    STOPPED = "STOPPED"
  }

  images_ids = {
    ubuntu_20 = "ocid1.image.oc1.me-jeddah-1.aaaaaaaay5jjjjj5bv2hh5553oi2ljo7nc36dxhx75sarcecs5ozlu374lja"
  }

  shapes = {
    small    = "VM.Standard.E2.1.Micro"
    standard = "VM.Standard.E2.1"
    standard12 = "VM.Standard2.1"
  }

  instances_configs = {
    "etcd-instance" = {
      shape    = local.shapes.standard
      image_id = local.images_ids.ubuntu_20
      subnet   = module.network.network.private_subnet
      network_sgs_ids = [
        module.network_sg.nsg.private_subnet_nsg.id,
      ]
    }
    "vault-instance" = {
      shape    = local.shapes.small
      image_id = local.images_ids.ubuntu_20
      subnet   = module.network.network.private_subnet
      network_sgs_ids = [
        module.network_sg.nsg.private_subnet_nsg.id,
      ]
    }

    "config-public" = {
      shape    = local.shapes.small
      image_id = local.images_ids.ubuntu_20
      subnet   = module.network.network.public_subnet
      network_sgs_ids = [
        module.network_sg.nsg.public_subnet_nsg.id,
      ]
    }
  }

  instances = {
    "jumpbox" = {
      config          = local.instances_configs["config-public"]
      volume_size     = 50
      autherized_keys = var.jumpbox_autherized_keys
      state           = local.instanceState.RUNNING
    }
    "etcd-1" = {
      config          = local.instances_configs["etcd-instance"]
      volume_size     = 50
      autherized_keys = var.private_instances_autherized_keys
      state           = local.instanceState.RUNNING
    }
    "etcd-2" = {
      config          = local.instances_configs["etcd-instance"]
      volume_size     = 50
      autherized_keys = var.private_instances_autherized_keys
      state           = local.instanceState.RUNNING
    }
    "etcd-3" = {
      config          = local.instances_configs["etcd-instance"]
      volume_size     = 50
      autherized_keys = var.private_instances_autherized_keys
      state           = local.instanceState.RUNNING
    }

    "vault" = {
      config          = local.instances_configs["vault-instance"]
      volume_size     = 50
      autherized_keys = var.private_instances_autherized_keys
      state           = local.instanceState.RUNNING
    }
  }
}