resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name

  setting {
    name  = "containerInsights"
    value = (var.enable_container_insights == true) ? "enabled" : "disabled"
  }

}

resource "aws_cloudwatch_log_group" "web-app" {
  name = format("%s-logs", var.cluster_name)

  tags = {
    Application = var.cluster_name
  }
}
