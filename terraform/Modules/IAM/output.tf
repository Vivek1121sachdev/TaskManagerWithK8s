output "eks_roles" {
  description = "Map of EKS IAM roles per cluster"
  value = {
    for cluster, role in aws_iam_role.eks_roles : cluster => role.arn
  }
}

output "node_roles" {
  description = "Map of Node IAM roles per cluster"
  value = {
    for cluster, role in aws_iam_role.node_roles : cluster => role.arn
  }
}
