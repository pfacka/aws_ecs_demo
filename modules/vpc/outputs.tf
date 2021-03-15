output "vpc_id" {
  value = aws_vpc.bi_vpc.id
}

output "subnet_group_name" {
  value = aws_db_subnet_group.subnet_group.name
}

output "private_subnet_ids" {
  value =  aws_subnet.subnet.*.id
}
