#----------------------------#
# Internet Gateway Id Output #
#----------------------------#

output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}

#-----------------------#
# NAT Gateway Id Output #
#-----------------------#

output "natgateway_id" {
  value = aws_nat_gateway.ngw.id
}