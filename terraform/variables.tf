variable "region" {
  description = "Region name in which all the infrastructure will create"
  type        = string
}

# variable "profile" {
#   description = "AWS Profile to select the aws account to create resources"
#   type        = string
# }

variable "vpc-cidr-block" {
  description = "VPC IP Range"
  type        = string
}

variable "vpc-tag" {
  description = "VPC Tag"
  type        = string
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

variable "bastion-host-ami" {
  type = string
  description = "AMI ID for the bastion Host"
  default = "ami-0e2c8caa4b6378d8c" // Ubuntu
}

variable "bastion-host-server-size" {
  type = string
  description = "EC2 Server size for the Bastion Host"
  default = "t2.micro"
}

variable "key_directory" {
  type = string
  description = "Path to save the keys"
}

variable "web" {
  type = string
  description = "Path to save public subnet keypairs"
}

variable "app" {
  type = string
  description = "Path to save private subnet keypairs"
}


variable "bastion-sg-name" {
  type = string
  description = "Bastion Host Security Group Name"
}

variable "rule_type_ingress" {
  type = string
  description = "Ingress Rule Type"
  default = "ingress"
}

variable "rule_type_egress" {
  type = string
  description = "Egress Rule Type"
  default = "egress"
}

variable "ssh_protocol" {
  type = number
  description = "Ingress Port Number for SSH"
  default = 22
}

variable "sg_protocol_tcp" {
   type = string
   description = "TCP Protocol for Security Group Rule"
   default = "tcp"
}

variable "bastion-sg-cidr-blocks" {
  type = list(string)
}

variable "any_rule" {
  type = number
  default = 0
}

variable "sg_protocol_any" {
  type = string
  default = "-1"
}

variable "global-cidr-block" {
  type = list(string)
  description = "Allowing all Internet traffic"
  default = [ "0.0.0.0/0" ]
}