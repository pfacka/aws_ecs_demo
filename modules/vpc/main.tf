resource "aws_vpc" "bi_vpc" {
  cidr_block           = var.private_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "BI Infrastructure"
  }
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "subnet" {
  count = length(data.aws_availability_zones.available.names)

  vpc_id                  = aws_vpc.bi_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.bi_vpc.cidr_block, 8, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

}
