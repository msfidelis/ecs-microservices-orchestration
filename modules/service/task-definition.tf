data "template_file" "task" {
  template = "${file("${path.module}/task-definitions/task.json")}"

  vars = {
    image               = "${aws_ecr_repository.registry.repository_url}"
    container_name      = "${var.service_name}"
    container_port      = "${var.container_port}"
    log_group           = "${aws_cloudwatch_log_group.logs.name}"
    desired_task_cpu    = "${var.desired_task_cpu}"
    desired_task_memory = "${var.desired_task_mem}"
    envoy_cpu           = "${var.envoy_cpu}"
    envoy_mem           = "${var.envoy_mem}"
    region              = "${var.region}"
  }
}

resource "aws_ecs_task_definition" "task" {
  family                   = "${var.cluster_name}-${var.service_name}"
  container_definitions    = "${data.template_file.task.rendered}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.desired_task_cpu
  memory                   = var.desired_task_mem

  execution_role_arn = "${aws_iam_role.ecs_execution_role.arn}"
  task_role_arn      = "${aws_iam_role.ecs_execution_role.arn}"
}
