module "mesh" {
  source                = "../appmesh"
  cluster_name          = "${var.cluster_name}"
}
