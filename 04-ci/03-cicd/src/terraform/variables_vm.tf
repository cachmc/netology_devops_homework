variable "ubuntu_version" {
  type        = string
  default     = "2004"
  description = "Version OS Ubuntu"
}

variable "centos_version" {
  type        = string
  default     = "7"
  description = "Version OS Centos"
}

variable "configuration_vms" {
  type = list(object({
    name               = string
    platform_id        = string
    zone               = string
    cores              = number
    memory             = number
    core_fraction      = number
    disk_volume        = number
    preemptible        = bool
    nat                = bool
    serial_port_enable = number
  }))
  default = [
    {
      name               = "sonar-01"
      platform_id        = "standard-v3"
      zone               = "ru-central1-a"
      cores              = 2
      memory             = 4
      core_fraction      = 20
      disk_volume        = 20
      preemptible        = true
      nat                = true
      serial_port_enable = 0
    },
    {
      name               = "nexus-01"
      platform_id        = "standard-v3"
      zone               = "ru-central1-a"
      cores              = 2
      memory             = 4
      core_fraction      = 20
      disk_volume        = 20
      preemptible        = true
      nat                = true
      serial_port_enable = 0
    }
  ]
  description = "Configuration VMs"
}
