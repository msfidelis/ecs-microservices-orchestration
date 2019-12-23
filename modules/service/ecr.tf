resource "aws_ecr_repository" "registry" {
    name = format("%s-%s", var.cluster_name, var.service_name)
}
