resource "aws_ecr_repository" "app_repository" {
  name = var.repository_name
}