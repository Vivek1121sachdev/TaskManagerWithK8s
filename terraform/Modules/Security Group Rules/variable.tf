variable "security_groups_cidr_ingress" {
  description = "A map of security group ingress rules for CIDR blocks"
  type = map(object({
    type              = string
    description       = string
    from_port         = number
    to_port           = number
    protocol          = string
    cidr_block        = list(string)
    security_group_id = string
  }))
}

variable "security_groups_ssg_ingress" {
  description = "A map of security group ingress rules for source security groups"
  type = map(object({
    type                     = string
    description              = string
    from_port                = number
    to_port                  = number
    protocol                 = string
    source_security_group_id = string
    security_group_id        = string
  }))
}

variable "security_groups_cidr_egress" {
  description = "A map of security group egress rules for CIDR blocks"
  type = map(object({
    type              = string
    description       = string
    from_port         = number
    to_port           = number
    protocol          = string
    cidr_block        = list(string)
    security_group_id = string
  }))
}

variable "security_groups_ssg_egress" {
  description = "A map of security group egress rules for source security groups"
  type = map(object({
    type                     = string
    description              = string
    from_port                = number
    to_port                  = number
    protocol                 = string
    source_security_group_id = string
    security_group_id        = string
  }))
}