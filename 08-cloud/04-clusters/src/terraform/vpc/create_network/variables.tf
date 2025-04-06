variable "network_name" {
  type        = string
  default     = null
  description = "Network name"
}

variable "subnets" {
  type        = list(object({
                  name             = string
                  zone             = string
                  cidr             = string
                  link_route_table = bool
                }))
  description = "Information about multiple subnets"
}

variable "route_table_name" {
  type        = string
  default     = ""
  description = "Route table name"
}

variable "static_routes" {
  type    = list(object({
              destination_prefix = string
              next_hop_address   = string
            }))
  default = []
  description = "Information about static routes"
}
