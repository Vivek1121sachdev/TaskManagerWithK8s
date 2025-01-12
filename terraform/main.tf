##################
# Provider Block #
##################

provider "aws" {
  region  = var.region
  # profile = var.profile
}


####################
# State Management #
####################

terraform {
  backend "s3" {
    bucket         = "task-manager-with-k8s"   
    key            = "terraform.tfstate"
    region         = "us-east-1"            
    encrypt        =  true

    # profile = "vivek"
  }
}

#############
# VPC Block #
#############

module "vpc" {
  source = "./Modules/VPC"

  vpc_config = {
    "EKS-VPC" = {
      cidr_block = var.vpc-cidr-block
      env        = var.env
    }
  }
}

################
# Subnet Block #
################

module "subnet" {
  source = "./Modules/Subnets"

  subnet_config = {

    // Web - Public Subnet
    "web-subnet" = {
      vpc_id            = module.vpc.vpc_ids["EKS-VPC"]
      cidr_block        = var.web_subnet
      availability_zone = var.subnet-availability_zone
      assign_public_ip  = true
      env               = var.env
    },

    // App - Private Subnet
    "app-subnet" = {
      vpc_id            = module.vpc.vpc_ids["EKS-VPC"]
      cidr_block        = var.app_subnet
      availability_zone = var.subnet-availability_zone
      assign_public_ip  = false
      env               = var.env
    }
  }
}

############
# Gateways #
############

module "Gateways" {
  source = "./Modules/Gateways"

  // Internet Gateway and NAT Gateway
  vpc_id     = module.vpc.vpc_ids
  subnet_ids = module.subnet.subnet_ids
}

#################
# Routing Table #
#################

// Routing Tables
module "RouteTable" {
  source     = "./Modules/RoutingTable"

  vpc_id     = module.vpc.vpc_ids
  subnet_ids = module.subnet.subnet_ids
  ig     = module.Gateways.internet_gateway_id
  nat    = module.Gateways.natgateway_id
}

#############
# ECR Block #
#############

module "ecr" {
  source = "./Modules/ECR"

  repositories = {
    backend = {
      name                 = "backend-repo"
      image_tag_mutability = "IMMUTABLE"
      scan                 = false
    },
    frontend = {
      name                 = "frontend-repo"
      image_tag_mutability = "IMMUTABLE"
      scan                 = false
    }
  }
}