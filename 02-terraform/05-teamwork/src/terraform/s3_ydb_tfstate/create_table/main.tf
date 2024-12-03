resource "aws_dynamodb_table" "create_table" {
  name         = var.yandex_db_table.name
  billing_mode = "PAY_PER_REQUEST"

  hash_key  = var.yandex_db_table.hash_key

  dynamic "attribute" {
    for_each = var.yandex_db_table.attribute

    content {
      name = attribute.value["name"]
      type = attribute.value["type"]
    }
  }
}
