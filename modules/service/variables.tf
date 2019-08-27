variable "vpc_id" {}

variable "region" {}

variable "cluster_listener" {}

variable "cluster_name" {}

variable "cluster_id" {}

variable "service_name" {}

variable "service_priority" {}

variable "platform_version" {
    default = "LATEST"
}

variable "cpu_evaluation_periods" {
    default = 5
}

variable "service_healthcheck" {
  type        = "map"
  default = {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 10
    interval            = 60
    matcher             = "200"
    path                = "/healthcheck"
    port                = 8080
  }
}

variable "container_port" {}

variable "desired_tasks" {}

variable "min_tasks" {}

variable "max_tasks" {}

variable "desired_task_cpu" {}

variable "desired_task_mem" {}

variable "cpu_to_scale_up" {}

variable "cpu_to_scale_down" {}

variable "cpu_verification_period" {}

variable "build_image" {}

variable "is_public" {}

variable "service_base_path" {}

variable "git_repository_owner" {}

variable "git_repository_name" {}

variable "git_repository_branch" {}

variable "availability_zones" {}