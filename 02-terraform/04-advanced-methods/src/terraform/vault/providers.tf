terraform {
  required_version = "~>1.8.4"
}

provider "vault" {
 address = var.vault_address
 skip_tls_verify = true
 token = var.vault_token
}
