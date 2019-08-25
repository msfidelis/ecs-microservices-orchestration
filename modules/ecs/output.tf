output "cluster_id" {
  value = "${aws_ecs_cluster.cluster.id}"
}

output "alb" {
  value = "${aws_alb.cluster_alb.arn}"
}

output "listener" {
  value = "${aws_alb_listener.default.arn}"
}
