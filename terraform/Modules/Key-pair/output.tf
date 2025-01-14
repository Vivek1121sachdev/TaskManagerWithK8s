output "key_pairs" {
  value = { for k, v in var.key_pairs : k => aws_key_pair.key_pair[k].key_name }
}