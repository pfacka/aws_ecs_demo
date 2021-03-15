output "dwh_address" {
  value = aws_db_instance.dwh_instance.address
}


output "dwh_master_username" {
  value = aws_db_instance.dwh_instance.username
}

output "dwh_master_password" {
  value = aws_db_instance.dwh_instance.password
}

#output "dwh_database_name" {
#}
#
#
#output "dwh_etl_username" {
#  value
#}
#
#output "dwh_etl_password" {
#  value
#
#}
