variable "vpc-cidr-block" {
  type = string
}

variable "vpc-tag" {
  type = string
}

variable "region" {
  type = string
}

variable "profile" {
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