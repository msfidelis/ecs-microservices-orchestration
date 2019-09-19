resource "aws_appmesh_virtual_router" "router" {
    count = var.enable_mesh == true ? 1 : 0

    name      = "${var.cluster_name}-${var.service_name}"
    mesh_name = var.cluster_mesh

    spec {
        listener {
            port_mapping {
                port     = var.container_port
                protocol = var.service_protocol
            }
        }
    }
}