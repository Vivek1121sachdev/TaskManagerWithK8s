resource "aws_instance" "ec2" {
  for_each = var.ec2_config

  subnet_id       = each.value.subnet_id
  ami             = each.value.ami
  instance_type   = each.value.instance_type
  key_name        = each.value.key_name
  user_data       = each.value.user_data
  vpc_security_group_ids = each.value.vpc_security_group_ids
  iam_instance_profile = each.value.iam_instance_profile

  private_ip = each.value.private_ip

  tags = {
    Env  = each.value.env
  }
}