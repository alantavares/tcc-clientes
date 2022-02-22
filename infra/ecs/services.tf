resource "aws_ecs_service" "web-api" {
  name            = var.cluster_name
  task_definition = aws_ecs_task_definition.web-api.family
  cluster         = aws_ecs_cluster.cluster.id
  launch_type     = "FARGATE"
  desired_count   = var.desired_tasks

  depends_on = [aws_iam_role_policy.ecs_service_role_policy, aws_ecs_task_definition.web-api]

  network_configuration {
    security_groups = [
      aws_security_group.app_sg.id,
      aws_security_group.nlb_sg.id
    ]
    subnets = [
      var.subnet1_private,
      var.subnet2_private
    ]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.app_nlb_target_group.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
}