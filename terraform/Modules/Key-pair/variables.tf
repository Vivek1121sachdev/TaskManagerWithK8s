variable "key_pairs" {
  type = map(object({
    save_path = string
  }))
}

variable "env" {
  type    = string
  default = "prod"
}