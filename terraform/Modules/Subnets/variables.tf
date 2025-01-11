variable "subnet_config" {
  description = "Configuration for subnets"
  type = map(object({
    vpc_id            = string
    cidr_block        = string
    availability_zone = string
    assign_public_ip  = bool
    # tag               = string
    env               = string
  }))
}