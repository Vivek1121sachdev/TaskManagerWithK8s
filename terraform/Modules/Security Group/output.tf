output "aws_security_group" {
  value = { for sg_key, sg_values in var.security_groups :
            sg_key => aws_security_group.sg[sg_values.name] }
}
