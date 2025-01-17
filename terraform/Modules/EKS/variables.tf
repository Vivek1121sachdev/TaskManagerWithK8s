variable "clusters_config" {
  description = "Configuration for multiple EKS clusters"
  type = map(object({
    region         = string
    subnets        = list(string)
    # ec2_ssh_key    = string
    cluster_iam_roles = string
    node_iam_roles = string
    node_count     = number
    node_type      = string
    node_disk_size = number
    env            = string
  }))
}

# variable "subnets" {
#   description = "Map of subnets for clusters"
#   type        = map(list(string)) # Example: { cluster-a = ["subnet-1", "subnet-2"], cluster-b = ["subnet-3", "subnet-4"] }
# }

# variable "cluster_iam_roles" {
#   description = "IAM roles for EKS clusters"
#   type        = map(string) # Example: { cluster-a = "arn:aws:iam::123456789012:role/cluster-a-role", cluster-b = "arn:aws:iam::123456789012:role/cluster-b-role" }
# }

# variable "node_iam_roles" {
#   description = "IAM roles for EKS nodes"
#   type        = map(string) # Example: { cluster-a = "arn:aws:iam::123456789012:role/cluster-a-node-role", cluster-b = "arn:aws:iam::123456789012:role/cluster-b-node-role" }
# }
