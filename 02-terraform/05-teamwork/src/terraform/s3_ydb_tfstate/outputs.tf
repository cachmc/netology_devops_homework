output "how_create_table" {
  description = "How create table for Yandex DB ?"
  value       = "\n\nterraform -chdir=./create_table init\n\ncp personal.auto.tfvars ./create_table\n\nterraform -chdir=./create_table apply -var 'document_api_endpoint=${yandex_ydb_database_serverless.create_db.document_api_endpoint}'\n\n"
}
