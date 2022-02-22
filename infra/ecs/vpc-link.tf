resource "aws_api_gateway_vpc_link" "nlb_link" {
  name        = "vpclink-${var.cluster_name}"
  description = "Link between API Gateway and application network"
  target_arns = [aws_lb.app_nlb.arn]
  depends_on = [aws_lb.app_nlb]
}