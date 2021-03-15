provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

module "cloud" {
  source        = "./modules/vpc"
  region        = var.aws_region
  private_cidr  = var.private_cidr
}


module "bi" {
  source             = "./bi"
  region             = var.aws_region
  vpc_id             = module.cloud.vpc_id
  private_cidr       = var.private_cidr
  subnet_group_name  = module.cloud.subnet_group_name
  private_subnet_ids = module.cloud.private_subnet_ids
}
