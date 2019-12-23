data "template_file" "task" {

  template = file(format("%s/task-definitions/task.json", path.module))

  vars = {
    image               = aws_ecr_repository.registry.repository_url
    container_name      = var.service_name
    container_port      = var.container_port
    log_group           = aws_cloudwatch_log_group.logs.name
    desired_task_cpu    = var.desired_task_cpu
    desired_task_memory = var.desired_task_mem
    mesh_name           = var.cluster_mesh
    virtual_node        = aws_appmesh_virtual_node.blue.name
    envoy_log_level     = var.envoy_log_level
    envoy_cpu           = var.envoy_cpu
    envoy_mem           = var.envoy_mem
    xray_cpu            = var.xray_cpu
    xray_mem            = var.xray_mem
    region              = var.region
  }
}

resource "aws_ecs_task_definition" "task" {
  family                   = format("%s-%s", var.cluster_name, var.service_name)

  container_definitions    = data.template_file.task.rendered
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                       = var.desired_task_cpu
  memory                    = var.desired_task_mem
  // cpu                      = var.desired_task_cpu + var.envoy_cpu + var.xray_cpu
  // memory                   = var.desired_task_mem + var.envoy_mem + var.xray_mem

  execution_role_arn = aws_iam_role.ecs_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_execution_role.arn
}
