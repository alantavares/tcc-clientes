variable "project_name" {
  description = ""
}

variable "cluster_name" {
  description = ""
}

variable "container_name" {
  description = ""
}

variable "webserver_container_name" {
  description = ""
}

variable "vpc_id" {
  description = ""
}

variable "availability_zones" {
  type        = list
  description = ""
}

variable "app_repository_name" {
  description = ""
}

variable "webserver_repository_name" {
  description = ""
}

variable "desired_tasks" {
  description = 6
}

variable "desired_task_cpu" {
  description = ""
}

variable "desired_webserver_task_cpu" {
  description = ""
}

variable "desired_app_task_cpu" {
  description = ""
}

variable "desired_task_memory" {
  description = ""
}

variable "desired_webserver_task_memory" {
  description = ""
}

variable "desired_app_task_memory" {
  description = ""
}

variable "min_tasks" {
  description = ""
}

variable "max_tasks" {
  description = ""
}

variable "cpu_to_scale_up" {
  description = ""
}

variable "cpu_to_scale_down" {
  description = ""
}

variable "alb_port" {
  description = ""
}

variable "container_port" {
  description = ""
}

variable "webserver_container_port" {
  description = ""
}

variable "subnet1" {
  description = ""
}

variable "subnet2" {
  description = ""
}

variable "subnet_alb_1" {
  description = ""
}

variable "subnet_alb_2" {
  description = ""
}

variable "bucket_name" {
  description = ""
}

variable "aws_region" {
  description = ""
}

variable "migration_deploy_cmd" {
  description = ""
}

variable "service_migration_name" {
  description = ""
}

variable "worker_consumer_name" {
  description = ""
}

variable "worker_consumer_container_port" {
  description = ""
}

variable "worker_consumer_container_name" {
  description = ""
}

variable "worker_consumer_deploy_cmd" {
  description = ""
}

variable "worker_consumer_desired_tasks" {
  description = 6
}

variable "worker_consumer_desired_task_cpu" {
  description = ""
}

variable "worker_consumer_desired_webserver_task_cpu" {
  description = ""
}

variable "worker_consumer_desired_app_task_cpu" {
  description = ""
}

variable "worker_consumer_desired_task_memory" {
  description = ""
}

variable "worker_consumer_desired_webserver_task_memory" {
  description = ""
}

variable "worker_consumer_desired_app_task_memory" {
  description = ""
}

variable "worker_consumer_min_tasks" {
  description = ""
}

variable "worker_consumer_max_tasks" {
  description = ""
}

variable "worker_consumer_cpu_to_scale_up" {
  description = ""
}

variable "worker_consumer_cpu_to_scale_down" {
  description = ""
}