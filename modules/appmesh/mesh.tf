resource "aws_appmesh_mesh" "mesh" {
  name = format("%s-mesh", var.cluster_name)

  spec {
    egress_filter {
      type = "ALLOW_ALL"
    }
  }
}