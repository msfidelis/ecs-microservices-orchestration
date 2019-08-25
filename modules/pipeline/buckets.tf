resource "aws_s3_bucket" "source" {
  bucket        = "${var.cluster_name}-${var.app_service_name}-${var.account_id}-pipeline"
  acl           = "private"
  force_destroy = true
}
