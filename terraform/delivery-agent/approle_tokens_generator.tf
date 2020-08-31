variable approles {
  type = map(object({
    path      = string
    role_id   = string
    secret_id = string
  }))
}

variable token {
  type = string
}

provider "vault" {
  address = "http://localhost:8200"
  token   = var.token
}

resource "vault_approle_auth_backend_login" "login" {
  for_each  = var.approles
  backend   = each.value.path
  role_id   = each.value.role_id
  secret_id = each.value.secret_id
}

output "tokens" {
  value = {
    for k, v in vault_approle_auth_backend_login.login :
    k => {
      token = v.client_token
    }
  }
}