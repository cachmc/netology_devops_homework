variable "nat_network_zone" {
  type        = string
  default     = "ru-central1-d"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "nat_subnet_name" {
  type        = string
  default     = "nat-subnet"
  description = "Name subnet"
}

variable "nat_subnet_cidr" {
  type        = list(string)
  default     = ["10.0.3.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}
