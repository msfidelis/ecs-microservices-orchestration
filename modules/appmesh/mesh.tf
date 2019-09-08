resource "aws_appmesh_mesh" "mesh" {
  name = "${var.cluster_name}-mesh"

  spec {
    egress_filter {
      type = "ALLOW_ALL"
    }
  }
}