variable "repositories" {
  description = "A map of repositories with their configurations."
  type = map(object({
    name                 = string
    image_tag_mutability = string
    scan                 = bool
  }))
}