resource "aws_service_discovery_private_dns_namespace" "private-service-discovery" {
  name        = var.cluster_domain
  description = format("%s private service discovery", var.cluster_name)
  vpc         = var.vpc_id
}