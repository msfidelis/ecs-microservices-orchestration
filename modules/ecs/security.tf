resource "aws_security_group" "alb_sg" {
  name        = "${var.cluster_name}-alb-sg"
  description = "ALB Security Group"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = "${lookup(var.listener, "port")}"
    to_port     = "${lookup(var.listener, "port")}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.cluster_name}-alb-sg"
  }
}