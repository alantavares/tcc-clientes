resource "aws_ecr_repository" "web-app" {
  name = var.app_repository_name
}

resource "aws_ecr_repository" "web-server" {
  name = var.webserver_repository_name
}
