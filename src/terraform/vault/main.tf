data "vault_generic_secret" "vault_example"{
 path = "secret/example"
}

resource "random_string" "vault_example_2_password" {
  length  = 32
  upper   = true
  lower   = true
  numeric = true
  special = true
}

resource "vault_generic_secret" "vault_example_2" {
  path = "secret/example_2"

  data_json = <<EOT
  {
    "username": "test_2",
    "password": "${random_string.vault_example_2_password.result}"
  }
EOT
}
