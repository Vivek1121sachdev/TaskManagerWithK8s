###################################################
# Security Group Rule for Ingress with CIDR Block #
###################################################

resource "aws_security_group_rule" "cidr_ingress" {
  for_each = var.security_groups_cidr_ingress

  type              = each.value.type
  description       = each.value.description
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_block
  security_group_id = each.value.security_group_id
}

###################################################################
# Security Group Rule for Ingress with Source Secuity Group Block #
###################################################################

resource "aws_security_group_rule" "ssg_ingress" {
  for_each                 = var.security_groups_ssg_ingress
  type                     = each.value.type
  description              = each.value.description
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  source_security_group_id = each.value.source_security_group_id
  security_group_id        = each.value.security_group_id
}

##################################################
# Security Group Rule for Egress with CIDR Block #
##################################################

resource "aws_security_group_rule" "cidr_egress" {
  for_each = var.security_groups_cidr_egress

  type              = each.value.type
  description       = each.value.description
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_block
  security_group_id = each.value.security_group_id
}

##################################################################
# Security Group Rule for Egress with Source Secuity Group Block #
##################################################################

resource "aws_security_group_rule" "ssg_egress" {
  for_each = var.security_groups_ssg_egress

  type                     = each.value.type
  description              = each.value.description
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  source_security_group_id = each.value.source_security_group_id
  security_group_id        = each.value.security_group_id
}