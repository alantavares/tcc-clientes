variable "project_name" {
  description = "The name of project"
}

variable "cluster_name" {
  description = "Cluster name in ECS"
}

variable "repository_name" {
  description = "API repository name on ECR"
}

variable "lb_port" {
  description = "Port on which Load Balancer will expose API"
}

variable "lb_prefix" {
  description = "Load balancer name prefix"
}

variable "container_port" {
  description = "Port on which the docker container will expose API"
}

variable "container_name" {
  description = "Container name"
}

variable "aws_region" {
  description = "Region where the infrastructure will be provisioned"
}

variable "vpc_id" {
  description = "VPC id"
}

variable "subnet1" {
  description = "VPC subnet, where the cluster is available."
}

variable "subnet2" {
  description = "VPC subnet, where the cluster is available."
}

variable "subnet1_private" {
  description = "Available subnet for NLB and ECS Cluster"
}

variable "subnet2_private" {
  description = "Available subnet for NLB and ECS Cluster"
}