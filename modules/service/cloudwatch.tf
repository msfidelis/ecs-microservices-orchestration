resource "aws_cloudwatch_log_group" "logs" {
  name = "${var.cluster_name}-${var.service_name}"

  tags = {
    Application = "${var.service_name}"
  }
}