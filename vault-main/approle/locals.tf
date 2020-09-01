locals {
  vault_entities = {
    "cicd-dev" = {
      aliases = ["cicd-dev-deployer"]
    }
    "cicd-uat" = {
      aliases = ["cicd-uat-deployer"]
    }
    "cicd-prod" = {
      aliases = ["cicd-prod-deployer"]
    }
    "token-generator" = {
      aliases = ["approle-token-generator"]
    }
    
    "wrapped-secret-id-generator" = {
      aliases = ["approle-wrapped-secret-id-generator"]
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
