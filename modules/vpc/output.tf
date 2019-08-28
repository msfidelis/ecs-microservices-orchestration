output "vpc_id" {
  value = "${aws_vpc.cluster_vpc.id}"
}

output "public_subnet_1a" {
  value = "${aws_subnet.public_subnet_us_east_1a.id}"
}

output "public_subnet_1b" {
  value = "${aws_subnet.public_subnet_us_east_1b.id}"
}