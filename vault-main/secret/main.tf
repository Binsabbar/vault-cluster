resource "vault_mount" "demo_apps" {
  path        = "secret/demo/apps/"
  type        = "kv"
  options = {
    version = 2
  }
}

resource "vault_mount" "demo_infra" {
  path        = "secret/demo/infra"
  type        = "kv"
  options = {
    version = 2
  }
}

resource "vault_mount" "stage_apps" {
  path        = "secret/stage/apps/"
  type        = "kv"
  options = {
    version = 2
  }
}

resource "vault_mount" "stage_infra" {
  path        = "secret/stage/infra"
  type        = "kv"
  options = {
    version = 2
  }
}

resource "vault_mount" "uat_apps" {
  path        = "secret/uat/apps/"
  type        = "kv"
  options = {
    version = 2
  }
}

resource "vault_mount" "uat_infra" {
  path        = "secret/uat/infra"
  type        = "kv"
  options = {
    version = 2
  }
}

resource "vault_mount" "production_apps" {
  path        = "secret/production/apps/"
  type        = "kv"
  options = {
    version = 2
  }
}

resource "vault_mount" "production_infra" {
  path        = "secret/production/infra"
  type        = "kv"
  options = {
    version = 2
  }
}