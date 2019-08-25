# Target Group for Web App
resource "aws_alb_target_group" "tg" {
    name        = "${var.cluster_name}-${var.service_name}"
    port        = "${var.container_port}"
    vpc_id      = "${var.vpc_id}"
    protocol    = "HTTP"
    target_type = "ip"

    lifecycle {
        create_before_destroy = true
    }
}