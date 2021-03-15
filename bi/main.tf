# fetch dwh master account password
data "aws_secretsmanager_secret" "dwh_password" {
  arn = "arn:aws:secretsmanager:eu-central-1:912707944927:secret:bi/dwh/db_password/-PNorCR"
}

data "aws_secretsmanager_secret_version" "dwh_password" {
  secret_id = data.aws_secretsmanager_secret.dwh_password.id
}


# fetch dwh etl account password
data "aws_secretsmanager_secret" "etl_password" {
  arn = "arn:aws:secretsmanager:eu-central-1:912707944927:secret:bi/dwh/etl_password-l98YgT"
}

data "aws_secretsmanager_secret_version" "etl_password" {
  secret_id = data.aws_secretsmanager_secret.etl_password.id
}

resource "aws_ecs_cluster" "bi_cluster" {
  name = "bi-cluster"
}


module "dwh" {
  source               = "../modules/dwh"
  region               = var.region
  vpc_id               = var.vpc_id
  private_cidr         = var.private_cidr

  ecs_cluster_id       = aws_ecs_cluster.bi_cluster.id
  private_subnet_ids   = var.private_subnet_ids
  master_password      = data.aws_secretsmanager_secret_version.dwh_password.secret_string
  etl_password         = data.aws_secretsmanager_secret_version.etl_password.secret_string

}



