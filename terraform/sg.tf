
# ALB SECURITY GROUP

resource "aws_security_group" "alb_sg" {

  name        = "letstype-alb-sg"
  description = "ALB Security Group"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP"

    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"

    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "letstype-alb-sg"
  }
}

# EKS SECURITY GROUP

resource "aws_security_group" "eks_sg" {

  name        = "letstype-eks-sg"
  description = "EKS Cluster Security Group"

  vpc_id = aws_vpc.main.id

  ingress {

    from_port = 0
    to_port   = 65535

    protocol = "tcp"

    security_groups = [
      aws_security_group.alb_sg.id
    ]
  }

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "letstype-eks-sg"
  }
}

# RDS SECURITY GROUP

resource "aws_security_group" "rds_sg" {

  name        = "letstype-rds-sg"
  description = "RDS PostgreSQL SG"

  vpc_id = aws_vpc.main.id

ingress {
  from_port = 5432
  to_port   = 5432
  protocol  = "tcp"

  security_groups = [
    aws_security_group.eks_sg.id
  ]
}

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "letstype-rds-sg"
  }
}