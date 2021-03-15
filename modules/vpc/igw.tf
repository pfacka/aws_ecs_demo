resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.bi_vpc.id

}


resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.bi_vpc.id

}


resource "aws_route" "igw_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}



resource "aws_route_table_association" "rta" {
  count = length(data.aws_availability_zones.available.names)

  subnet_id      = aws_subnet.subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

