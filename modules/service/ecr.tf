resource "aws_ecr_repository" "registry" {
    name = "${var.cluster_name}-${var.service_name}"
}
