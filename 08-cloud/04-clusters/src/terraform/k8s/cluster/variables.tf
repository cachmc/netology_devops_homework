variable "cluster_name" {
  type        = string
  default     = null
  description = "Name of the K8s cluster"
}

variable "service_account_name" {
  type        = string
  default     = null
  description = "Service account name"
}

variable "security_group_name" {
  type        = string
  default     = "k8s_cluster_security_group"
  description = "Security group name"
}

variable "k8s_version" {
  type        = string
  default     = "1.29"
  description = "Version K8s"
}

variable "count_master_nodes" {
  type        = list(number)
  default     = [1]
  description = "How many master nodes need created"
}

variable "cluster_public_ip" {
  type        = bool
  default     = true
  description = "Cluster public IP"
}

variable "kms_key_id" {
  type        = string
  default     = null
  description = "KMS key"
}

variable "network" {
  type        = object({
    id     = string
    subnets = list(object({
      id    = string
      zone  = string
      cidrs = list(string)
    }))
  })
  default     = null
  description = "Configuration network"
}

variable "node_group_name" {
  type        = string
  default     = null
  description = "Node group name"
}

variable "node_group_description" {
  type        = string
  default     = "Default node group"
  description = "Node group name"
}

variable "instance_template" {
  type        = object({
    name                      = string
    platform_id               = string
    resources                 = object({
      cores         = number
      core_fraction = number
      memory        = number
    })
    boot_disk                 = object({
      size = number
      type = string
    })
    network_acceleration_type = string
    network_nat               = bool
    preemptible               = bool
  })
  default     = {
    name                      = "worker-node"
    platform_id               = "standard-v3"
    resources                 = {
      cores         = 2
      core_fraction = 50
      memory        = 1
    }
    boot_disk                 = {
      size = 64
      type = "network-hdd"
    }
    network_acceleration_type = "standard"
    network_nat               = true
    preemptible               = true
  }
  description = "Configuration instance"
}

variable "auto_scale_policy" {
    type        = object({
      min     = number
      max     = number
      initial = number
    })
    default     = {
      min     = 1
      max     = 2
      initial = 1
    }
    description = "Auto scale policy"
}

variable "deploy_policy" {
  type        = object({
    max_expansion   = number
    max_unavailable = number
  })
  default     = {
    max_expansion   = 1
    max_unavailable = 1
  }
  description = "Deploy policy"
}

variable "maintenance_policy" {
  type        = object({
    auto_upgrade       = bool
    auto_repair        = bool
    maintenance_window = object({
      start_time = string
      duration   = string
    })
  })
  default     = {
    auto_upgrade       = true
    auto_repair        = true
    maintenance_window = {
      start_time = "22:00"
      duration   = "10h"
    }
  }
  description = "Maintenance policy"
}

variable "node_labels" {
  type        = object({})
  default     = {}
  description = "For dynamic block 'node_labels'"
}

variable "node_taints" {
  type        = list(string)
  default     = []
  description = "Node taints'"
}

variable "labels" {
  type        = object({})
  default     = {}
  description = "For dynamic block 'labels'"
}

variable "allowed_unsafe_sysctls" {
  type        = list(string)
  default     = []
  description = "Allowed unsafe sysctls'"
}
