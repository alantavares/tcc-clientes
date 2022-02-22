### NLB
# Target Group for Web App
resource "aws_lb_target_group" "app_nlb_target_group" {

  name_prefix = var.lb_prefix
  port        = var.container_port
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  deregistration_delay = 10

  lifecycle {
    create_before_destroy = true
  }

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    port                = var.container_port
    protocol            = "TCP"
  }


  depends_on = [aws_lb.app_nlb]
}

resource "aws_lb" "app_nlb" {
  name     = "${var.cluster_name}-nlb"
  internal = true
  load_balancer_type = "network"

  subnets = [
    var.subnet1,
    var.subnet2
  ]

  tags = {
    Name        = "${var.cluster_name}-nlb"
    Environment = var.cluster_name
  }
}

resource "aws_lb_listener" "web_app" {
  load_balancer_arn = aws_lb.app_nlb.arn
  port              = var.lb_port
  protocol          = "TCP"
  depends_on        = [aws_lb_target_group.app_nlb_target_group]

  default_action {
    target_group_arn = aws_lb_target_group.app_nlb_target_group.arn
    type             = "forward"
  }
}
