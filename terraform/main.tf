##################
# Provider Block #
##################

provider "aws" {
  region  = var.region
  profile = var.profile
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