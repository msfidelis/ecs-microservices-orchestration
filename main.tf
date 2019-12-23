################################
###### QUICK EDIT'S HERE  ######
################################

###### CLUSTER OPTIONS  ######

# Customize the Cluster Name
variable "cluster_name" {
  description = "ECS Cluster Name"
  default     = "demo"
}

# Customize your AWS Region
variable "aws_region" {
  description = "AWS Region for the VPC"
  default     = "us-east-1"
}

provider "aws" {
  region = var.aws_region
}

data "aws_caller_identity" "current" {}
