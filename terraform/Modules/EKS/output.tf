output "eks_clusters" {
  description = "Details of created EKS clusters"
  value = {
    for cluster, config in aws_eks_cluster.eks_clusters :
    cluster => {
      endpoint = config.endpoint
      arn      = config.arn
    }
  }
}

output "eks_node_groups" {
  description = "Details of EKS node groups"
  value = {
    for cluster, config in aws_eks_node_group.eks_node_groups :
    cluster => {
      name       = config.node_group_name
      instance   = config.instance_types[0]
      disk_size  = config.disk_size
    }
  }
}
