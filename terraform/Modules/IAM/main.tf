resource "aws_iam_role" "eks_roles" {
  for_each = toset(var.cluster_names)

  name = "${each.key}-eks-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_policy" {
  for_each  = aws_iam_role.eks_roles
  role      = each.value.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role" "node_roles" {
  for_each = toset(var.cluster_names)

  name = "${each.key}-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "aws_eks_worker_node_policy" {
  for_each  = aws_iam_role.node_roles
  role      = each.value.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"

  depends_on = [aws_iam_role.node_roles]
}

resource "aws_iam_role_policy_attachment" "ec2_read_only" {
  for_each  = aws_iam_role.node_roles
  role      = each.value.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

  depends_on = [aws_iam_role.node_roles]
}

resource "aws_iam_role_policy_attachment" "aws_eks_cni_policy" {
  for_each  = aws_iam_role.node_roles
  role      = each.value.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

  depends_on = [aws_iam_role.node_roles]
}