resource "aws_ecr_repository" "repos" {
  for_each = toset(var.repos)

  name                 = "streamlinepay-${var.env}-${each.key}" # New naming convention
  image_tag_mutability = "IMMUTABLE"                            # Production best practice
  force_delete         = true

  encryption_configuration {
    encryption_type = "AES256"
  }

  image_scanning_configuration {
    scan_on_push = true # Enable vulnerability scanning
  }

  tags = {
    Environment = var.env
    Service     = each.key
  }
}