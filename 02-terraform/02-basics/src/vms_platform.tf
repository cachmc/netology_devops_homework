#vms vars
variable "vm_project" {
  type        = string
  default     = "netology"
  description = "VM project name"
}

variable "vm_env" {
  type        = string
  default     = "develop"
  description = "VM ENV"
}

variable "vm_type" {
  type        = string
  default     = "platform"
  description = "VM type"
}


#vms configuration
variable "configuration" {
  type = map(map(object({
    cores = number
    memory = number
    core_fraction = number
  })))
  default = {
    vms_resources = {
      web = {
        cores = 2
        memory = 1
        core_fraction = 5
      }
      db = {
        cores = 2
        memory = 2
        core_fraction = 20
      }
    }
  }
  description = "Configuration"
}


#vm_web
variable "vm_web_network_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vm_web_subnet_name" {
  type        = string
  default     = "web-subnet"
  description = "Name subnet"
}

variable "vm_web_subnet_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vm_web_os_version" {
  type        = string
  default     = "2004"
  description = "Version OS Ubuntu"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "https://yandex.cloud/ru/docs/compute/concepts/vm-platforms"
}

variable "vm_web_preemptible" {
  type        = bool
  default     = true
  description = "A VM that runs for no more than 24 hours and can be terminated by Compute Cloud at any time"
}

variable "vm_web_nat" {
  type        = bool
  default     = false
  description = "Enable NAT"
}


#vm_db
variable "vm_db_network_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vm_db_subnet_name" {
  type        = string
  default     = "db-subnet"
  description = "Name subnet"
}

variable "vm_db_subnet_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vm_db_os_version" {
  type        = string
  default     = "2004"
  description = "Version OS Ubuntu"
}

variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "VM name"
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "https://yandex.cloud/ru/docs/compute/concepts/vm-platforms"
}

variable "vm_db_preemptible" {
  type        = bool
  default     = true
  description = "A VM that runs for no more than 24 hours and can be terminated by Compute Cloud at any time"
}

variable "vm_db_nat" {
  type        = bool
  default     = false
  description = "Enable NAT"
}
