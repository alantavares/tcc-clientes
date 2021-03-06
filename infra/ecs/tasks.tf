data "template_file" "api_task" {
  template = file("${path.module}/task-definitions/api-task.json")

  vars = {
    webserver_image               = aws_ecr_repository.web-server.repository_url
    webserver_container_name      = var.webserver_container_name
    webserver_container_port      = var.webserver_container_port
    desired_webserver_task_cpu    = var.desired_webserver_task_cpu
    desired_webserver_task_memory = var.desired_webserver_task_memory
    image                         = aws_ecr_repository.web-app.repository_url
    container_name                = var.container_name
    container_port                = var.container_port
    desired_app_task_cpu          = var.desired_app_task_cpu
    desired_app_task_memory       = var.desired_app_task_memory
    log_group                     = aws_cloudwatch_log_group.web-app.name
    aws_region                    = var.aws_region
  }
}

resource "aws_ecs_task_definition" "web-api" {
  family                   = "${var.cluster_name}_app"
  container_definitions    = data.template_file.api_task.rendered
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.desired_task_cpu
  memory                   = var.desired_task_memory

  execution_role_arn = aws_iam_role.ecs_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_execution_role.arn
}

data "template_file" "worker_consumer_task" {
  template = file("${path.module}/task-definitions/worker-task.json")

  vars = {
    image                   = aws_ecr_repository.web-app.repository_url
    container_name          = var.worker_consumer_container_name
    container_port          = var.worker_consumer_container_port
    desired_app_task_cpu    = var.worker_consumer_desired_app_task_cpu
    desired_app_task_memory = var.worker_consumer_desired_app_task_memory
    log_group               = aws_cloudwatch_log_group.worker-consumer.name
    deploy_cmd              = var.worker_consumer_deploy_cmd
    aws_region              = var.aws_region
  }
}

resource "aws_ecs_task_definition" "worker-consumer" {
  family                   = "${var.worker_consumer_name}_app"
  container_definitions    = data.template_file.worker_consumer_task.rendered
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.worker_consumer_desired_task_cpu
  memory                   = var.worker_consumer_desired_task_memory

  execution_role_arn = aws_iam_role.ecs_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_execution_role.arn
}