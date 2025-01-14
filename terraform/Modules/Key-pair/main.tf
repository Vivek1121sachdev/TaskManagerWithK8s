######################
# AWS Key Pair Block #
######################

resource "aws_key_pair" "key_pair" {
  for_each = var.key_pairs

  key_name   = each.key
  public_key = tls_private_key.key_pair[each.key].public_key_openssh
  tags = {
    Name = each.key
    Env  = var.env
  }
}

###########################
# Generating Private Keys #
###########################

resource "tls_private_key" "key_pair" {
  for_each = var.key_pairs

  algorithm = "RSA"
  rsa_bits  = 4096
}

################################
# Saving Private Keys to Local #
################################

resource "local_file" "private_key" {
  for_each = var.key_pairs

  content  = tls_private_key.key_pair[each.key].private_key_pem
  filename = "${each.value.save_path}/${each.key}.pem"
}