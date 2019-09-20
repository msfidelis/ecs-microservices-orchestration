module "mesh" {
  source                = "../appmesh"
  cluster_name          = "${var.cluster_name}"
}


module "service_discovery" {
  source                = "../service_discovery"
  cluster_name          = var.cluster_name
  cluster_domain        = var.cluster_domain == "" ? "${var.cluster_name}.local" : var.cluster_domain
  vpc_id                = var.vpc_id
}
