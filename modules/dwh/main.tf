resource "aws_security_group" "dwh_sg" {
  name        = "dwh-sg"
  description = "DWH RDS instance security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    cidr_blocks     = [var.private_cidr]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = [var.private_cidr]
  }
}


resource "aws_db_subnet_group" "subnet_group" {
  name        = "dwh-subnet-group"
  description = "dwh subnet group"
  subnet_ids  = var.private_subnet_ids

}


resource "aws_db_instance" "dwh_instance" {
  identifier            = "prod-dwh"
  name                  = "dwh"
  allocated_storage     = 20
  max_allocated_storage = 1000
  storage_type          = "gp2"
  engine                = var.dwh_engine
  engine_version        = var.dwh_engine_version

  instance_class                        = var.dwh_instance_class
  username                              = var.master_username
  password                              = var.master_password
  backup_window                         = "00:15-01:45"
  backup_retention_period               = 7
  maintenance_window                    = "Fri:22:15-Fri:23:00"
  performance_insights_enabled          = false
  publicly_accessible                   = false
  allow_major_version_upgrade           = false

  final_snapshot_identifier = "final-snapshot-prod-dwh"

  db_subnet_group_name      = aws_db_subnet_group.subnet_group.name
  vpc_security_group_ids    = [aws_security_group.dwh_sg.id]
}

provider "postgresql" {
  scheme   = "awspostgres"
  host     = aws_db_instance.dwh_instance.address
  port     = 5432
  database = "postgres"
  username = var.master_username
  password = var.master_password
  sslmode  = "require"
  superuser = false
}

resource "postgresql_role" "etl_role" {
  name        = var.etl_username
  password    = var.etl_password
  login       = true
}

resource "postgresql_database" "dwh_database" {
  name              = "dwh_pliat"
  owner             = var.master_username
  template          = "template0"
  lc_collate        = "C"
  connection_limit  = -1
  allow_connections = true
}
