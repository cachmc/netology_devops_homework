resource "yandex_kms_symmetric_key" "create_kms_keys" {
  for_each = { for i, key in var.kms_keys_configuration: i => key }

  name              = each.value.name
  description       = each.value.description
  default_algorithm = each.value.default_algorithm
  rotation_period   = each.value.rotation_period
}
