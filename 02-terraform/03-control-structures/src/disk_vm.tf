#Create Disks for VM Storage

resource "yandex_compute_disk" "create_storage_disk" {
  count = 3

  name = "storage-disk-${count.index+1}"
  size = var.configuration_disk.size
  type = var.configuration_disk.type
  zone = var.configuration_disk.zone

  labels = {
    host = "storage"
  }
}
