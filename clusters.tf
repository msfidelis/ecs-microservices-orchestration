module "cluster_example" {

    source              = "./modules/ecs"
    vpc_id              = "${module.vpc.vpc_id}"
    cluster_name        = "${var.cluster_name}"

    listener = {
        port     = 8080
        protocol = "HTTP"
        certificate_arn = ""
        ssl_policy      = "" // Default "ELBSecurityPolicy-TLS-1-1-2017-01"        
    }

    availability_zones  = [
        "${module.vpc.public_subnet_1a}",
        "${module.vpc.public_subnet_1b}"
    ]

}