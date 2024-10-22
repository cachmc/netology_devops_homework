#VMs vars

variable "ubuntu_version" {
  type        = string
  default     = "2004"
  description = "Version OS Ubuntu"
}

variable "configuration_vm_web" {
  type = object({
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
  })
  default = {
    name               = "web"
    platform_id        = "standard-v1"
    zone               = "ru-central1-a"       
    cores              = 2
    memory             = 1
    core_fraction      = 5
    disk_volume        = 5
    preemptible        = true
    nat                = true
    serial_port_enable = 1
  }
  description = "Configuration VM Web"
}

variable "configuration_vm_db" {
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
      name               = "main"
      platform_id        = "standard-v3"
      zone               = "ru-central1-a"
      cores              = 4
      memory             = 4
      core_fraction      = 20
      disk_volume        = 20
      preemptible        = true
      nat                = false
      serial_port_enable = 1
    },
    {
      name               = "replica"
      platform_id        = "standard-v3"
      zone               = "ru-central1-a"
      cores              = 2
      memory             = 2
      core_fraction      = 20
      disk_volume        = 15
      preemptible        = true
      nat                = false
      serial_port_enable = 1
    }
  ]
  description = "Configuration VM DB"
}

variable "configuration_vm_storage" {
  type = object({
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
  })
  default = {
    name               = "storage"
    platform_id        = "standard-v3"
    zone               = "ru-central1-a"
    cores              = 2
    memory             = 2
    core_fraction      = 20
    disk_volume        = 5
    preemptible        = true
    nat                = true
    serial_port_enable = 1
  }
  description = "Configuration VM Storage"
}
