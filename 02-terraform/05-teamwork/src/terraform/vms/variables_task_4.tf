###vars for task 4

variable "ip_address" {
  type        = string
  default     = "192.168.0.1"
  description = "ip-адрес"

  validation {
    condition     = can(regex("^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$", var.ip_address))
    error_message = "IP address is not valid"
  }
}

variable "ip_addresses_list" {
  type        = list(string)
  default     = ["192.168.0.1", "1.1.1.1", "1270.0.0.1"]
  description = "список ip-адресов"

  validation { 
    condition     = alltrue([for ip_address in var.ip_addresses_list : can(regex("^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$", ip_address))])
    error_message = "IP address is not valid"
  }
}
