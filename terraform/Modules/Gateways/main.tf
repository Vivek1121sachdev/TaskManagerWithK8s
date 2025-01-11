#------------------------#
# Internet Gateway Setup #
#------------------------#

resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id["EKS-VPC"]
  tags = {
    Name = "TaskManagerIGW"
    Env  = var.env
  }
}

#--------------------------#
# Elastic IP Address Setup #
#--------------------------#

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "TaskManagerElasticIP"
    Env  = var.env
  }
}


#-------------------#
# NAT Gateway Setup #
#-------------------#

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.subnet_ids["web-subnet"]

  tags = {
    Name = "TaskManagerNG"
    Env  = var.env
  }
}