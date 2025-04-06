output "keys" {
  value = [ for key in yandex_kms_symmetric_key.create_kms_keys: 
    {
      name = key.name
      id   = key.id
    }
  ]
  description = "List KMS keys"
}
