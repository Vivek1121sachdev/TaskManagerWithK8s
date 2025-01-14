variable "security_groups" {
  type = map(object({
    name        = string
    description = string
    vpc_id      = string
    tag         = any
  }))
}