variable "project_name" {
  description = "The name of project"
}

# ECS
variable "cluster_name" {
  description = "Cluster name in ECS"
}

# ECR
variable "app_repository_name" {
  description = "PHP/Symfony API repository name on ECR"
}

# ECR
variable "webserver_repository_name" {
  description = "Name of the NGINX Webserver repository on the ECR"
}

# ALB
variable "alb_port" {
  description = "HTTP port on which Load Balancer (ALB) will expose the NGINX / PHP / Symfony service"
}

# Container PHP/Symfony
variable "container_port" {
  description = "Port on which the docker container will expose the PHP/Symfony service"
}

# Container PHP/Symfony
variable "container_name" {
  description = "PHP/Symfony container name"
}

# Container NGINX
variable "webserver_container_port" {
  description = "Port on which the docker container will expose NGINX"
}

# Container NGINX
variable "webserver_container_name" {
  description = "NGINX container name"
}

# Region
variable "aws_region" {
  description = "Region where the infrastructure will be provisioned"
}

# VPC
variable "vpc_id" {
  description = "VPC"
}

# Subnet
variable "subnet1" {
  description = "VPC subnet, where the cluster is available."
}

# Subnet
variable "subnet2" {
  description = "VPC subnet, where the cluster is available."
}

# ALB Subnet
variable "subnet_alb_1" {
  description = "Available subnet for ALB. It is in ALB that the SSL settings are located and also where Route53 points the CNAME"
}

# ALB Subnet
variable "subnet_alb_2" {
  description = "Available subnet for ALB. It is in ALB that the SSL settings are located and also where Route53 points the CNAME"
}

# S3 Bucket
variable "bucket_name" {
  description = "S3 Bucket where files will be stored and versioned"
}

variable "migration_deploy_cmd" {
  description = "Command that will be executed when deploying the migration container"
}

variable "service_migration_name" {
  description = "Name of Migration service"
}