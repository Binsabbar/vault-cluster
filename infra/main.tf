terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "binsabbar"
    workspaces {
      name = "vault-infra"
    }
  }
}

provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

resource "oci_identity_compartment" "compartment" {
  name           = "vault-cloud"
  description    = "compartment that holds PoCs resource for vault"
  compartment_id = var.tenancy_ocid
}

module "network" {
  source = "./network"

  compartment_id = oci_identity_compartment.compartment.id
}