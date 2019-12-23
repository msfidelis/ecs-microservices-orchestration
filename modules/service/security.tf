resource "aws_security_group" "service_sg" {
  name        = format("%s-%s-sg", var.cluster_name, var.service_name)
  description = format("%s-%s", var.cluster_name, var.service_name)

  vpc_id      = var.vpc_id

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
    Name = format("%s-%s-sg", var.cluster_name, var.service_name)
  }
}