#Disks vars

variable "configuration_disk" {
  type = object({
    size = number
    type = string
    zone = string
  })
  default = {
    size = 1
    type = "network-hdd"
    zone = "ru-central1-a"
  }
  description = "Configuration Disk"
}
