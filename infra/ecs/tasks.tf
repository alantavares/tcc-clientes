data "template_file" "app_task" {
  template = file("${path.module}/task-definitions/api-task.json")

  vars = {
    image                         = aws_ecr_repository.app_repository.repository_url
    vpc_id                        = var.vpc_id
    aws_region                    = var.aws_region
    container_name                = var.container_name
    container_port                = var.container_port
    desired_app_task_cpu          = var.desired_app_task_cpu
    desired_app_task_memory       = var.desired_app_task_memory
    log_group                     = aws_cloudwatch_log_group.app_log_group.name
    datadog_api_key               = var.datadog_api_key
  }
}

resource "aws_ecs_task_definition" "web-api" {
  family                   = "${var.cluster_name}_app"
  container_definitions    = data.template_file.app_task.rendered
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.desired_task_cpu
  memory                   = var.desired_task_memory

  execution_role_arn = aws_iam_role.ecs_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_execution_role.arn
}