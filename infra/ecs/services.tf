resource "aws_ecs_service" "web-api" {
  name            = var.cluster_name
  task_definition = aws_ecs_task_definition.web-api.family
  cluster         = aws_ecs_cluster.cluster.id
  launch_type     = "FARGATE"
  desired_count   = var.desired_tasks
  #force_new_deployment = true

  depends_on = [aws_iam_role_policy.ecs_service_role_policy]

  network_configuration {
    security_groups = [
      aws_security_group.app_sg.id,
      aws_security_group.alb_sg.id
    ]
    subnets = [
      var.subnet1,
      var.subnet2
    ]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.api_target_group.arn
    container_name   = var.webserver_container_name
    container_port   = var.webserver_container_port
  }

  lifecycle {
    create_before_destroy = true
  }

  # depends_on = [aws_alb_target_group.api_target_group]
}

resource "aws_ecs_service" "migration" {
  name            = var.service_migration_name
  task_definition = aws_ecs_task_definition.migration.family
  cluster         = aws_ecs_cluster.cluster.id
  launch_type     = "FARGATE"
  desired_count   = 1

  depends_on = [aws_iam_role_policy.ecs_service_role_policy]

  network_configuration {
    security_groups = [
      aws_security_group.app_sg.id,
      aws_security_group.alb_sg.id
    ]
    subnets = [
      var.subnet1,
      var.subnet2
    ]
    assign_public_ip = true
  }
}