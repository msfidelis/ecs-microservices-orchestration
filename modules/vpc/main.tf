# Example VPC
resource "aws_vpc" "cluster_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = format("%s-vpc", var.cluster_name)
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.cluster_vpc.id
  tags = {
        Name = format("%s-igw", var.cluster_name)
    }
}

# Route to Internet Gateway
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.cluster_vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}