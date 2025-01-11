variable "vpc_id" {
  type = any
}

variable "subnet_ids" {
  description = "Map of subnet IDs"
  type        = map(string)
}

variable "global_cidr" {
  description = "Allows traffic from the internet"
  type        = string
  default     = "0.0.0.0/0"
}

variable "env" {
  description = "Environment"
  type        = string
  default     = "dev"
}

variable "ig" {
  type = string
}

variable "nat" {
  type = string
}
