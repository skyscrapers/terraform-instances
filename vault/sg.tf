resource "aws_security_group" "vault" {
  name        = "vault"
  description = "vault specific rules"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port       = 8200
    to_port         = 8200
    protocol        = "tcp"
    security_groups = ["${module.alb.sg_id}"]
  }

  ingress {
    from_port = 8200
    to_port   = 8201
    protocol  = "tcp"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
