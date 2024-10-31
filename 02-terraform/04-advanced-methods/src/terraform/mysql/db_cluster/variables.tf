variable "ha_cluster" {
  type        = bool
  default     = true
  description = "Creating a DB cluster of two nodes"
}

variable "cluster_name" {
  type        = string
  default     = null
  description = "Name of the DB cluster"
}

variable "network_id" {
  type        = string   
  description = "ID of the network in which the cluster will be created"
}

variable "subnet_zones" {
  type        = list(string)  
  description = "List of subnet zones"
}

variable "subnet_ids" {
  type        = list(string)  
  description = "List of subnet IDs"
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "For dynamic block 'labels'"
}
