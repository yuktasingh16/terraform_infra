resource "aws_db_subnet_group" "main" {
  name       = "${var.name_prefix}-rds-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.name_prefix}-rds-subnet-group"
  }
}

resource "aws_db_instance" "postgres" {
  identifier = "${var.name_prefix}-postgres"

  engine            = "postgres"
  engine_version    = "16"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp3"

  db_name             = var.name_prefix
  username            = "postgres"
  password            = var.db_password
  publicly_accessible = false
  skip_final_snapshot = false
  final_snapshot_identifier = format(
    "%s-postgres-final-snapshot-%s",
    var.name_prefix,
    replace(replace(timestamp(), ":", "-"), ".", "-")
  )

  vpc_security_group_ids = [var.security_group_id]
  db_subnet_group_name   = aws_db_subnet_group.main.name

  tags = {
    Name = "${var.name_prefix}-postgres"
  }

  backup_retention_period = 7
  deletion_protection     = true
}
