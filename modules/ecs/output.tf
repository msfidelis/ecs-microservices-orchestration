output "cluster_id" {
  value = aws_ecs_cluster.cluster.id
}

output "cluster_mesh" {
  value = module.mesh.mesh_name
}

output "cluster_service_discovery" {
  value = module.service_discovery.sd
}

output "alb" {
  value = aws_alb.cluster_alb.arn
}

output "listener" {
  value = aws_alb_listener.default.arn
}
