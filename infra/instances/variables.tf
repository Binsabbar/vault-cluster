variable "availability_domain" {
  type = object({
    name = string
  })
}

variable "compartment" {
  type = object({
    id = string
  })
}

variable "vnc" {
  type = object({
    id = string
  })
}

variable "instances" {
  type = map(object({
    volume_size     = number
    state           = string
    autherized_keys = string
    config = object({
      shape           = string
      image_id        = string
      network_sgs_ids = list(string)
      subnet = object({
        id                         = string,
        prohibit_public_ip_on_vnic = bool
      })
    })
  }))
  description = "map of instances configurations"
}

 