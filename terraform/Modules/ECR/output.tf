output "ecr_repository_arns" {
  value = { for k, repo in aws_ecr_repository.repo : k => repo.arn }
}

output "ecr_repository_urls" {
  value = { for k, repo in aws_ecr_repository.repo : k => repo.repository_url }
}