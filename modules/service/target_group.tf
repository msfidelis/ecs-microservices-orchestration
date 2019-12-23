# Target Group for Web App
resource "aws_alb_target_group" "tg" {
    name        = format("%s-%s", var.cluster_name, var.service_name)
    port        = var.container_port
    vpc_id      = var.vpc_id

    protocol    = "HTTP"
    target_type = "ip"

    health_check {
        healthy_threshold   = lookup(var.service_healthcheck, "healthy_threshold", "3")
        unhealthy_threshold = lookup(var.service_healthcheck, "unhealthy_threshold", "10")
        timeout             = lookup(var.service_healthcheck, "timeout", "10")
        interval            = lookup(var.service_healthcheck, "interval", "10")
        matcher             = lookup(var.service_healthcheck, "matcher", "200")
        path                = lookup(var.service_healthcheck, "path", "/healthcheck")
        port                = lookup(var.service_healthcheck, "port", "8080")
    }

    lifecycle {
        create_before_destroy = true
    }
}
