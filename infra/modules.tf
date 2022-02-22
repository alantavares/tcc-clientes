module "ecs" {
  project_name                  = var.project_name
  source                        = "./ecs"
  cluster_name                  = "${var.cluster_name}-${terraform.workspace}"
  repository_name               = "${var.repository_name}-${terraform.workspace}"
  container_name                = var.container_name
  vpc_id                        = var.vpc_id
  subnet1                       = var.subnet1
  subnet2                       = var.subnet2
  desired_tasks                 = local.workspace["desired_tasks"]
  max_tasks                     = local.workspace["max_tasks"]
  min_tasks                     = local.workspace["min_tasks"]
  desired_task_cpu              = local.workspace["desired_task_cpu"]
  desired_app_task_cpu          = local.workspace["desired_app_task_cpu"]
  desired_task_memory           = local.workspace["desired_task_memory"]
  desired_app_task_memory       = local.workspace["desired_app_task_memory"]
  cpu_to_scale_up               = local.workspace["cpu_to_scale_up"]
  cpu_to_scale_down             = local.workspace["cpu_to_scale_down"]
  memory_to_scale_up            = local.workspace["memory_to_scale_up"]
  memory_to_scale_down          = local.workspace["memory_to_scale_down"]

  subnet1_private               = var.subnet1_private
  subnet2_private               = var.subnet2_private
  lb_port                       = var.lb_port
  lb_prefix                     = var.lb_prefix
  container_port                = var.container_port
  aws_region                    = var.aws_region  
  availability_zones            = [ var.subnet1, var.subnet2 ]
}