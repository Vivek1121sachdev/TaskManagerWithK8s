
variable "ec2_config" {
  type = map(object({
    subnet_id       = string
    ami             = string
    instance_type   = string
    key_name        = string
    env             = string
    user_data       = optional(string)
    vpc_security_group_ids = list(string)
    iam_instance_profile = optional(string)
    private_ip = optional(string)
    }))
}