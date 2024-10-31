output "vault_example" {
 value = "${nonsensitive(data.vault_generic_secret.vault_example.data)}"
}

output "vault_example_2" {
 value = "${nonsensitive(vault_generic_secret.vault_example_2.data)}"
}
