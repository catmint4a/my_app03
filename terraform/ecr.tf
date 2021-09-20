resource "aws_ecr_repository" "myapp04" {
  name                 = "myapp04"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}