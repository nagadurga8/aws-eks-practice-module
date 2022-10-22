resource "aws_vpc" "eks" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = {
    Name = var.vpc_name
  }

}
resource "aws_subnet" "eks-public-subnets" {
  count                   = length(var.public_subnet_cidr_blocks)
  vpc_id                  = aws_vpc.eks.id
  cidr_block              = element(var.public_subnet_cidr_blocks, count.index)
  availability_zone       = element(var.availability_zone, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.public_subnet_name}-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "eks-igw" {
  vpc_id = aws_vpc.eks.id
  tags = {
    Name = "${var.vpc_name}-IGW"
  }
}

resource "aws_default_route_table" "eks-rt" {
  default_route_table_id = aws_vpc.eks.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks-igw.id
  }

  tags = {
    Name = "${var.vpc_name}-RT"
  }
}


resource "aws_default_security_group" "eks-sg" {
  vpc_id = aws_vpc.eks.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.vpc_name}-SG"
  }
}
