variable "region" {
  description = "AWS region"
  type = string
}

variable "vpc_id" {
  description = "VPC ID"
  type = string
}


variable "private_cidr" {
  type = string 
}

variable "subnet_group_name" {
  type = string 
}

variable "private_subnet_ids" {
  type = list(string)
}



variable "dwh_instance_class" {
  description = "DWH DB instance class"
  default     = "db.t3.micro"
}


variable "dwh_engine" {
  description = "DB engine"
  default     = "postgres"
}


variable "dwh_engine_version" {
  description = "DB engine version"
  default     = 12.4
}


variable "master_username" {
  description = "DWH master username"
  default     = "postgres"
}

variable "master_password" {
  description = "DWH master password"
  type        = string
}


variable "etl_username" {
  description = "DWH ETL user name"
  default     = "etl"
}

variable "etl_password" {
  description = "DWH ETL user name"
  type        = string
}



# Management Service

variable "ecs_cluster_id" {
  type = string
}

