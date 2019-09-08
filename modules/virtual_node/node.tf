resource "aws_appmesh_virtual_node" "service" {
  name      = "${var.service_name}"
  mesh_name = "${var.mesh_name}"

  spec {
    backend {
      virtual_service {
        virtual_service_name = "${var.service_name}.local"
      }
    }

    listener {
      port_mapping {
        port     = var.service_port
        protocol = var.service_protocol
      }
    }

    service_discovery {
      dns {
        hostname = "${var.service_name}.local"
      }
    }
  }
}