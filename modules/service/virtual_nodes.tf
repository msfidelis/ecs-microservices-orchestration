resource "aws_appmesh_virtual_node" "blue" {

  name      = "${var.cluster_name}-${var.service_name}-blue"
  mesh_name = "${var.cluster_mesh}"

  spec {
    backend {
        virtual_service {
            virtual_service_name = "${var.cluster_name}-${var.service_name}.local"
        }
    }

    listener {
        port_mapping {
            port     = var.container_port
            protocol = "http"
        }

        health_check {
            healthy_threshold   = var.service_healthcheck.healthy_threshold
            unhealthy_threshold = var.service_healthcheck.unhealthy_threshold
            timeout_millis      = var.service_healthcheck.timeout   * 1000
            interval_millis     = var.service_healthcheck.interval  * 1000
            path                = var.service_healthcheck.path
            port                = var.service_healthcheck.port
            protocol            = var.service_protocol
        }

    }

    service_discovery {
      aws_cloud_map {
        attributes = {
          stack = "blue"
        }
        service_name   = "blue"
        namespace_name = "${var.cluster_name}-${var.service_name}"
      }
    }
  }
}


resource "aws_appmesh_virtual_node" "green" {

  name      = "${var.cluster_name}-${var.service_name}-green"
  mesh_name = "${var.cluster_mesh}"

  spec {
    backend {
        virtual_service {
            virtual_service_name = "${var.cluster_name}-${var.service_name}.local"
        }
    }

    listener {
        port_mapping {
            port     = var.container_port
            protocol = "http"
        }

        health_check {
            healthy_threshold   = var.service_healthcheck.healthy_threshold
            unhealthy_threshold = var.service_healthcheck.unhealthy_threshold
            timeout_millis      = var.service_healthcheck.timeout   * 1000
            interval_millis     = var.service_healthcheck.interval  * 1000
            path                = var.service_healthcheck.path
            port                = var.service_healthcheck.port
            protocol            = var.service_protocol
        }

    }

    service_discovery {
      aws_cloud_map {
        attributes = {
          stack = "green"
        }
        service_name   = "green"
        namespace_name = "${var.cluster_name}-${var.service_name}"
      }
    }
  }
}