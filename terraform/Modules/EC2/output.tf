output "instance_ids" {
  value = { for k, v in aws_instance.ec2 : k => v.id }
}

output "instance_eni" {
  value = { for k,v in aws_instance.ec2 : k => v.primary_network_interface_id }
}