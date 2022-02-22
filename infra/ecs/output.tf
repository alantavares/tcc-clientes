output "repository_url" {
  value = aws_ecr_repository.app_repository.repository_url
}

output "vpc_link_name" {
  value = aws_api_gateway_vpc_link.nlb_link.name
}

output "lb_name" {
  value = aws_lb.app_nlb.name
}
