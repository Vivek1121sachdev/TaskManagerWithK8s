######################
# Route-Table-Public #
######################

resource "aws_route_table" "public-rt" {
  vpc_id = var.vpc_id["EKS-VPC"]

  route {
    cidr_block = var.global_cidr
    gateway_id = var.ig
  }

  tags = {
    Name = "web-route-table"
    Env  = var.env
  }
}

##########################################
# Public Route-Table Association for Web #
##########################################

// web subnet
resource "aws_route_table_association" "web-rt-association" {
  subnet_id      = var.subnet_ids["web-subnet"]
  route_table_id = aws_route_table.public-rt.id
}

// web subnet
resource "aws_route_table_association" "web-rt-association-b" {
  subnet_id      = var.subnet_ids["web-subnet-b"]
  route_table_id = aws_route_table.public-rt.id
}


###############################
# Route-Table-Private for App #
###############################

resource "aws_route_table" "app-private-rt" {
  vpc_id = var.vpc_id["EKS-VPC"]

  route {
    cidr_block = var.global_cidr
    nat_gateway_id = var.nat
  }

  lifecycle {
    ignore_changes = [route]
  }
  
  tags = {
    Name = "private-route-table"
    Env  = var.env
  }
}

#########################################
# Private Route-Table Association - App #
#########################################

resource "aws_route_table_association" "app-private-rt-association-a" {
  subnet_id      = var.subnet_ids["app-subnet-a"]
  route_table_id = aws_route_table.app-private-rt.id
}

resource "aws_route_table_association" "app-private-rt-association-b" {
  subnet_id      = var.subnet_ids["app-subnet-b"]
  route_table_id = aws_route_table.app-private-rt.id
}