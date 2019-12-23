resource "aws_appmesh_virtual_router" "router" {

    name      = format("%s-%s", var.cluster_name, var.service_name)
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