output "vpc_id" {
  value = aws_vpc.bi_vpc.id
}

output "private_subnet_ids" {
  value =  aws_subnet.subnet.*.id
}
