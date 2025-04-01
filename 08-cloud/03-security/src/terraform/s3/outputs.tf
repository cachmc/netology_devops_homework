output "urls_pub_files" {
  value = [ for i, file in yandex_storage_object.upload_files: {
    name = file.source
    url  = "https://${file.bucket}.storage.yandexcloud.net/${file.key}"
  }]
  description = "URLs of published files"
}
