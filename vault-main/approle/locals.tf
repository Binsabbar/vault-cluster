locals {
  vault_entities = {
    "cicd_dev" = {
      aliases = ["cicd_dev_deployer"]
    }
    "cicd_uat" = {
      aliases = ["cicd_uat_deployer"]
    }
    "cicd_prod" = {
      aliases = ["cicd_prod_deployer"]
    }

    "wrapped_secret_id_generator" = {
      aliases = ["approle_wrapped_secret_id_generator"]
    }
  }

  // Computed variables used in the `for_each`
  flattened_aliases = flatten([
    for k, v in local.vault_entities : [
      for aliase in v.aliases : { entity = k, role = aliase }
    ]
  ])
  backend_roles = flatten([
    for k, v in local.vault_entities : [
      v.aliases
    ]
  ])
}
