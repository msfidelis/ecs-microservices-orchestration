module "mesh" {
  source                = "../appmesh"
  cluster_name          = "${var.cluster_name}"
}


module "service_discovery" {
  source                = "../service_discovery"
  cluster_name          = "${var.cluster_name}"
  vpc_id                = "${var.vpc_id}"
}
