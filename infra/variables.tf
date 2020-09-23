variable "tenancy_ocid" { type = string }
variable "user_ocid" { type = string }
variable "fingerprint" { type = string }
variable "private_key_path" { type = string }
variable "region" { type = string }
variable "safe_ips" { type = list }
variable "jumpbox_autherized_keys" { type = string }
variable "private_instances_autherized_keys" { type = string }