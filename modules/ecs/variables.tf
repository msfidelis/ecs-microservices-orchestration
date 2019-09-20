variable "cluster_name" {}

variable "cluster_domain" {
  default = ""
}

variable "vpc_id" {}

variable "listener" {
  type        = "map"
  default = {
    port            = "80"
    certificate_arn = ""
    ssl_policy      = "ELBSecurityPolicy-TLS-1-1-2017-01"
  }
}

variable "availability_zones" {
  type = list(string)
}