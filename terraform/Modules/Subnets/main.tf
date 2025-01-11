resource "aws_subnet" "subnets" {
  for_each = var.subnet_config

  vpc_id                  = each.value.vpc_id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.assign_public_ip

  tags = {
    Name = each.key
    Env  = each.value.env
  }
}