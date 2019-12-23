module "vpc" {
  source         = "./modules/vpc"
  cluster_name   = var.cluster_name
}