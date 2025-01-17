resource "aws_eks_cluster" "eks_clusters" {
  for_each = var.clusters_config

  name     = each.key
  role_arn = each.value.cluster_iam_roles
  version  = "1.27"

  access_config {
    authentication_mode = "API"
    bootstrap_cluster_creator_admin_permissions = true 
  }

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access = true
    subnet_ids = each.value.subnets
  }

  tags = {
    Name        = "${each.key}-eks-cluster"
    Environment = each.value.env
  }
}

resource "aws_eks_node_group" "eks_node_groups" {
  for_each = var.clusters_config

  cluster_name    = aws_eks_cluster.eks_clusters[each.key].name
  node_group_name = "${each.key}-node-group"
  node_role_arn   = each.value.node_iam_roles

  scaling_config {
    desired_size = each.value.node_count
    min_size     = 1
    max_size     = each.value.node_count
  }

  # remote_access {
  #   ec2_ssh_key               = each.value.ec2_ssh_key
  # }

  instance_types = [each.value.node_type]
  disk_size      = each.value.node_disk_size
  subnet_ids     = each.value.subnets

  tags = {
    Name        = "${each.key}-node-group"
    Environment = each.value.env
  }
}
