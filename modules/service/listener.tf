resource "aws_lb_listener_rule" "service" {
  listener_arn = var.cluster_listener
  priority     = var.service_priority

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.tg.arn
  }

  condition {
    field  = "path-pattern"
    values = var.service_base_path
  }
}