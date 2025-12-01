resource "aws_ecr_repository" "repos" {
  for_each = toset(var.repos)

  name                 = "${var.env}-${each.key}"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Environment = var.env
    Service     = each.key
  }
}
