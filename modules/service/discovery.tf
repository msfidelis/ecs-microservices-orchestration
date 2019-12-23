resource "aws_service_discovery_service" "service" {

  name = format("%s-%s", var.cluster_name, var.service_name)

  dns_config {
    namespace_id = var.cluster_service_discovery.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }

}