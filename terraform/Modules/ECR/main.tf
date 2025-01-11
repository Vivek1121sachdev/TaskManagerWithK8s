resource "aws_ecr_repository" "repo" {
  for_each = var.repositories

  name                 = each.value["name"]
  image_tag_mutability = each.value["image_tag_mutability"] 
  
  image_scanning_configuration {
    scan_on_push = each.value.scan
  }
  
}

resource "aws_ecr_lifecycle_policy" "rule" {
  for_each = var.repositories

  repository = aws_ecr_repository.repo[each.key].name

  policy = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Keep last 3 images",
      "selection": {
        "tagStatus": "any",
        "countType": "imageCountMoreThan",
        "countNumber": 3
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}