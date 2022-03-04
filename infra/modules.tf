module "ecs" {
  project_name                  = var.project_name
  organization                  = var.organization
  source                        = "./ecs"
  cluster_name                  = "${var.cluster_name}-${terraform.workspace}"
  app_repository_name           = "${var.app_repository_name}-${terraform.workspace}"
  webserver_repository_name     = "${var.webserver_repository_name}-${terraform.workspace}"
  bucket_name                   = "${var.bucket_name}-${terraform.workspace}"
  service_migration_name        = "${var.service_migration_name}-${terraform.workspace}"
  container_name                = var.container_name
  webserver_container_name      = var.webserver_container_name
  vpc_id                        = var.vpc_id
  subnet1                       = var.subnet1
  subnet2                       = var.subnet2
  desired_tasks                 = local.workspace["desired_tasks"]
  max_tasks                     = local.workspace["max_tasks"]
  min_tasks                     = local.workspace["min_tasks"]
  desired_task_cpu              = local.workspace["desired_task_cpu"]
  desired_webserver_task_cpu    = local.workspace["desired_webserver_task_cpu"]
  desired_app_task_cpu          = local.workspace["desired_app_task_cpu"]
  desired_task_memory           = local.workspace["desired_task_memory"]
  desired_webserver_task_memory = local.workspace["desired_webserver_task_memory"]
  desired_app_task_memory       = local.workspace["desired_app_task_memory"]
  cpu_to_scale_up               = local.workspace["cpu_to_scale_up"]
  cpu_to_scale_down             = local.workspace["cpu_to_scale_down"]

  subnet_alb_1                  = var.subnet_alb_1
  subnet_alb_2                  = var.subnet_alb_2
  alb_port                      = var.alb_port
  container_port                = var.container_port
  webserver_container_port      = var.webserver_container_port
  arn_certificado               = var.arn_certificado
  aws_region                    = var.aws_region  
  availability_zones            = [ var.subnet1, var.subnet2 ]
  migration_deploy_cmd          = var.migration_deploy_cmd
}