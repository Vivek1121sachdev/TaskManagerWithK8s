provider "aws" {
  region = var.region
  profile = var.profile
}

module "vpc" {
  source = "./Modules/VPC"

  vpc_config = {
    "EKS-VPC" = {
        cidr_block = var.vpc-cidr-block
        tag = var.vpc-tag
    }
  }
}