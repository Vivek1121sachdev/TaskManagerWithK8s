variable "region" {
  description = "Region name in which all the infrastructure will create"
  type = string
}

# variable "profile" {
#   description = "AWS Profile to select the aws account to create resources"
#   type = string
# }

variable "vpc-cidr-block" {
  description = "VPC IP Range"
  type = string
}

variable "vpc-tag" {
  description = "VPC Tag"
  type = string
}

variable "web_subnet" {
  description = "Public Subnet IP Range"
  type        = string
}

variable "app_subnet" {
  description = "Private Subnet IP Range"
  type        = string
}

variable "subnet-availability_zone" {
  description = "Availablity Zone in which all the resources will deploy"
  type        = string
}

variable "env" {
  type        = string
  description = "ENV value to identify the current stage"
  default     = "dev"
}