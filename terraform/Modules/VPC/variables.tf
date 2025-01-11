variable "vpc_config" {
  description = "Map of VPC configurations"
  type = map(object({
    cidr_block        = string
    env               = string
}))
}
