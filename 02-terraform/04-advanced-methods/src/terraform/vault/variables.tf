variable "vault_address" {
  type        = string
  default     = "http://192.168.65.7:8200"
  description = "HTTP address to Vault"
}

variable "vault_token" {
  type        = string
  description = "https://developer.hashicorp.com/vault/docs/concepts/tokens"
}
