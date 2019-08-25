resource "aws_security_group" "service_sg" {
  name        = "${var.cluster_name}-${var.service_name}-sg"
  description = "${var.cluster_name}-${var.service_name}"

  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = var.container_port
    to_port     = var.container_port
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
    Name = "${var.cluster_name}-${var.service_name}-sg"
  }
}