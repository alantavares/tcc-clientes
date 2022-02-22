variable "project_name" {
  description = ""
}

variable "cluster_name" {
  description = ""
}

variable "container_name" {
  description = ""
}

variable "vpc_id" {
  description = ""
}

variable "availability_zones" {
  type        = list
  description = ""
}

variable "repository_name" {
  description = ""
}

variable "desired_tasks" {
  description = ""
}

variable "desired_task_cpu" {
  description = ""
}

variable "desired_app_task_cpu" {
  description = ""
}

variable "desired_task_memory" {
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

variable "lb_port" {
  description = ""
}

variable "lb_prefix" {
  description = ""
}

variable "container_port" {
  description = ""
}

variable "subnet1" {
  description = ""
}

variable "subnet2" {
  description = ""
}

variable "subnet1_private" {
  description = ""
}

variable "subnet2_private" {
  description = ""
}

variable "aws_region" {
  description = ""
}

variable "memory_to_scale_up" {
  description = ""
}

variable "memory_to_scale_down" {
  description = ""
}

variable "datadog_api_key" {

}