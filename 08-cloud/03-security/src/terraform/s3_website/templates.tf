resource "local_file" "index_html" {
  content = templatefile("${path.module}/index_html.tftpl", {
    url            = "https://${var.s3_configuration.bucket.name}"
    urls_pub_files = var.s3_configuration.upload_files
  })

  filename = "${abspath(path.module)}/files/index.html"
}
