output "vpc_ids" {
  value = { for k, v in aws_vpc.vpc : k => v.id }
}

output "vpc_cidr" {
  value = { for k, v in aws_vpc.vpc : k => v.cidr_block }
}