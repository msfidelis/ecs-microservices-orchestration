resource "aws_ecs_service" "service" {
  name            = "${var.service_name}"
  task_definition = "${aws_ecs_task_definition.task.arn}"
  cluster         = "${var.cluster_id}"
  desired_count   = "${var.desired_tasks}"

  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = ["${aws_security_group.service_sg.id}"]
    subnets          = "${var.availability_zones}"
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = "${aws_alb_target_group.tg.arn}"
    container_name   = "${var.service_name}"
    container_port   = "${var.container_port}"
  }

  lifecycle {
    ignore_changes = ["desired_count"]
  }

  depends_on = ["aws_lb_listener_rule.service"]
}