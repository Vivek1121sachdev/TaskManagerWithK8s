output "subnet_ids" {
  value = { for s in aws_subnet.subnets : s.tags["Name"] => s.id }
}