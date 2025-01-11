resource "aws_vpc" "vpc" {
  for_each = var.vpc_config

  cidr_block = each.value.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  
  tags = {
    Name = each.value.tag
  }
}
