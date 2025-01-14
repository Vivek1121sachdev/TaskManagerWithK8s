##################
# Provider Block #
##################

provider "aws" {
  region  = var.region
  profile = var.profile
}


####################
# State Management #
####################

terraform {
  backend "s3" {
    bucket  = "task-manager-with-k8s"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    encrypt = true

    profile = "vivek"
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

    // App - Private Subnet - A
    "app-subnet-a" = {
      vpc_id            = module.vpc.vpc_ids["EKS-VPC"]
      cidr_block        = var.app_subnet
      availability_zone = var.subnet-availability_zone
      assign_public_ip  = false
      env               = var.env
    },

    // App - Private Subnet - B
    "app-subnet-b" = {
      vpc_id            = module.vpc.vpc_ids["EKS-VPC"]
      cidr_block        = "10.0.3.0/24"
      availability_zone = "us-east-1b"
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
  source = "./Modules/RoutingTable"

  vpc_id     = module.vpc.vpc_ids
  subnet_ids = module.subnet.subnet_ids
  ig         = module.Gateways.internet_gateway_id
  nat        = module.Gateways.natgateway_id
}

##################
# KeyPairs Block #
##################

module "key_pair" {
  source = "./Modules/Key-pair"

  key_pairs = {

    // Bastion Host
    bastion-server-kp = {
      name      = "bastion-server-kp"
      save_path = "${var.key_directory}/${var.web}"
    },
    eks-node-kp = {
      name      = "eks-node-kp"
      save_path = "${var.key_directory}/${var.app}"
    }
  }
}

########################
# Security Group Block #
########################
module "security_groups" {
  source = "./Modules/Security Group"
  
  security_groups = {

   "bastion-sg" = {
      name        = var.bastion-sg-name
      description = "Bastion security group"
      vpc_id      = module.vpc.vpc_ids["EKS-VPC"]
      tag = {
        Name = var.bastion-sg-name
        Env  = var.env
      }
    }
  }
}

########################
# Security Group Rules #
########################

module "security_group_rules" {
  source = "./Modules/Security Group Rules"
  depends_on = [ module.security_groups ]

  security_groups_cidr_ingress = {

    // Bastion SSH Rule
    bastion-sg-ssh-ingress = {
      type              = var.rule_type_ingress
      description       = "Allow SSH to bastion Host"
      from_port         = var.ssh_protocol
      to_port           = var.ssh_protocol
      protocol          = var.sg_protocol_tcp
      cidr_block        = var.bastion-sg-cidr-blocks
      security_group_id = module.security_groups.aws_security_group["bastion-sg"].id
    },
}
  security_groups_ssg_ingress = {}

  security_groups_cidr_egress = {
  
    // Bastion Host
    bastion-sg-egress = {
      type              = var.rule_type_egress
      description       = "Allow all outbound traffic"
      from_port         = var.any_rule
      to_port           = var.any_rule
      protocol          = var.sg_protocol_any
      cidr_block        = var.global-cidr-block
      security_group_id = module.security_groups.aws_security_group["bastion-sg"].id

    }
}

  security_groups_ssg_egress = {}
}

#############
# EC2 Block #
#############

module "ec2" {
  source = "./Modules/EC2"

  ec2_config = {

    // Bastion Host
    "bastion-host-server" = {
      subnet_id       = module.subnet.subnet_ids["web-subnet"]
      ami             = var.bastion-host-ami
      instance_type   = var.bastion-host-server-size
      key_name        = module.key_pair.key_pairs["bastion-server-kp"]  
      vpc_security_group_ids = [module.security_groups.aws_security_group["bastion-sg"].id] 
      env             = var.env
    }
  }
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

#############
# IAM Block #
#############

module "iam" {
  source = "./Modules/IAM"

  cluster_names = ["cluster-a"] // Need to change this names after clusters are created.
}

#############
# EKS Block #
#############

module "eks" {
  source = "./Modules/EKS"

  clusters_config = {
    cluster-a = {
      region            = "us-east-1"
      subnets           = [module.subnet.subnet_ids["app-subnet-a"], module.subnet.subnet_ids["app-subnet-b"]]
      cluster_iam_roles = module.iam.eks_roles["cluster-a"]
      node_iam_roles    = module.iam.node_roles["cluster-a"]
      ec2_ssh_key    = module.key_pair.key_pairs["eks-node-kp"]
      node_count     = 1
      node_type      = "t3.medium"
      node_disk_size = 20

      env = "dev"
    }
  }

}
