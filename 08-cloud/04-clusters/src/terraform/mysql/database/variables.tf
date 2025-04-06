variable "cluster_id" {
  type        = string
  default     = null
  description = "MySQL DB cluster ID"
}

variable "name" {
  type        = string
  default     = null
  description = "MySQL DB name"
}

variable "username" {
  type        = string
  default     = null
  description = "User for MySQL DB"
}

variable "roles" {
  type        = list(string)
  default     = null
  description = "User roles for MySQL DB"
}

variable "connection_limits" {
  type        = object({
    max_questions_per_hour   = number
    max_updates_per_hour     = number
    max_connections_per_hour = number
    max_user_connections     = number
  })
  default     = {
    max_questions_per_hour   = 0
    max_updates_per_hour     = 0
    max_connections_per_hour = 0
    max_user_connections     = 0
  }
  description = "Configuration backup"
}

variable "global_permissions" {
  type        = list(string)
  default     = ["PROCESS"]
  description = "Global permissions'"
}

variable "authentication_plugin" {
  type        = string
  default     = "SHA256_PASSWORD"
  description = "Authentication plugin"
}
