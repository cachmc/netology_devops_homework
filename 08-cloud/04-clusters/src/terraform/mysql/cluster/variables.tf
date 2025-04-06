variable "labels" {
  type        = map(string)
  default     = {}
  description = "For dynamic block 'labels'"
}

variable "name" {
  type        = string
  default     = null
  description = "Name of the DB cluster"
}

variable "environment" {
  type        = string
  default     = null
  description = "Environment of the DB cluster"
}

variable "mssql_version" {
  type        = string
  default     = null
  description = "Version MySQL"
}

variable "security_group_ids" {
  type        = list(string)
  default     = []
  description = "List of security group ids"
}

variable "deletion_protection" {
  type        = bool
  default     = null
  description = "Deletion protection DB cluster"
}

variable "mysql_config" {
  type        = object({})
  default     = {}
  description = "For dynamic block 'mysql_config'"
}

variable "access" {
  type        = object({
    data_lens     = bool
    data_transfer = bool
    web_sql       = bool
  })
  default     = {
    data_lens     = false
    data_transfer = false
    web_sql       = false
  }
  description = "Configuration access"
}

variable "count_nodes" {
  type        = list(number)
  default     = [1]
  description = "How many nodes need created"
}

variable "network" {
  type        = object({
    id     = string
    subnet = object({
      ids   = list(string)
      zones = list(string)
    })
  })
  default     = null
  description = "Configuration network"
}

variable "host" {
  type        = object({
    priority        = number
    backup_priority = number
  })
  default     = {
    priority        = 0
    backup_priority = 0
  }
  description = "Configuration host"
}

variable "resources" {
  type        = object({
    resource_preset_id = string
    disk_type_id       = string
    disk_size          = number
  })
  default     = null
  description = "Configuration node"
}

variable "maintenance_window" {
  type        = object({
    type = string
    day  = string
    hour = number
  })
  default     = null
  description = "Configuration maintenance"

  validation {
     condition = contains(["ANYTIME", "WEEKLY"], var.maintenance_window.type)
     error_message = "Invalid type maintenance mode."
   }
}

variable "backup_window_start" {
  type        = object({
    hours   = number
    minutes = number
  })
  default     = null
  description = "Configuration backup"
}

variable "performance_diagnostics" {
  type        = object({
    enabled                      = bool
    sessions_sampling_interval   = number
    statements_sampling_interval = number
  })
  default     = {
    enabled                      = false
    sessions_sampling_interval   = 60
    statements_sampling_interval = 600
  }
  description = "Performance diagnostics"
}
