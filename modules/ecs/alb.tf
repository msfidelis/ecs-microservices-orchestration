resource "aws_alb" "cluster_alb" {
  name            = "${var.cluster_name}-alb"
  subnets         = "${var.availability_zones}"
  security_groups = ["${aws_security_group.alb_sg.id}"]

  tags = {
    Name        = "${var.cluster_name}-alb"
    Environment = "${var.cluster_name}"
  }
}
