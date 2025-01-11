variable "vpc_id" {
  type = any
}

variable "env" {
  description = "Environment"
  type        = string
  default     = "dev"
}

variable "subnet_ids" {
  description = "Map of subnet IDs"
  type        = map(string)
}