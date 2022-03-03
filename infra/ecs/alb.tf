# Target Group for Web App
resource "aws_alb_target_group" "api_target_group" {
  name        = "${var.cluster_name}-alb-tg"
  port        = var.webserver_container_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  deregistration_delay = 30

  lifecycle {
    create_before_destroy = true
  }

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 5
    interval            = 30
    matcher             = "200"
    path                = "/healthcheck"
    port                = var.webserver_container_port
  }


  depends_on = [aws_alb.app_alb]
}

resource "aws_alb" "app_alb" {
  name     = "${var.cluster_name}-alb"

  subnets = [
   var.subnet_alb_1,
   var.subnet_alb_2
  ]

  security_groups = [
    aws_security_group.app_sg.id,
    aws_security_group.alb_sg.id
  ]

  tags = {
    Name        = "${var.cluster_name}-alb"
    Environment = var.cluster_name
  }
}

resource "aws_alb_listener" "web_app" {
  load_balancer_arn = aws_alb.app_alb.arn
  port              = var.alb_port
  protocol          = "HTTP"
  depends_on        = [aws_alb_target_group.api_target_group]

  default_action {
    target_group_arn = aws_alb_target_group.api_target_group.arn
    type             = "forward"
  }
}

resource "aws_alb_listener" "web_app_https" {
  load_balancer_arn = aws_alb.app_alb.arn
  port              = 443
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.arn_certificado
                      
  protocol          = "HTTPS"
  depends_on        = [aws_alb_target_group.api_target_group]

  default_action {
    target_group_arn = aws_alb_target_group.api_target_group.arn
    type             = "forward"
  }
}
