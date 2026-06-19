resource "aws_db_subnet_group" "main" {
  name = "letstype-rds-subnet-group"

  subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]

  tags = {
    Name = "letstype-rds-subnet-group"
  }
}

resource "aws_db_instance" "postgres" {

  identifier = "letstype-postgres"

  engine         = "postgres"
  engine_version = "16"

  instance_class = "db.t3.micro"

  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = "letstype"
  username = "postgres"
  password = "LetsType123"

  publicly_accessible = false

  skip_final_snapshot = true

  vpc_security_group_ids = [
    aws_security_group.rds_sg.id
  ]

  db_subnet_group_name = aws_db_subnet_group.main.name

  tags = {
    Name = "letstype-postgres"
  }
}