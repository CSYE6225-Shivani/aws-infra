//vpc definition
resource "aws_vpc" "aws_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.dns_host_names

  tags = {
    Name =                var.vpc_name
  }
}

//---------------------------------------------------------------
//internet gateway for vpc
resource "aws_internet_gateway" "aws_gateway" {
  depends_on = [aws_vpc.aws_vpc]
  vpc_id     = aws_vpc.aws_vpc.id

  tags = {
    Name = var.ig_name
  }
}

//---------------------------------------------------------------
//Public subnet
resource "aws_subnet" "public_subnet" {
  depends_on              = [aws_vpc.aws_vpc]
  for_each                = var.public_subnet_cidr_block
  cidr_block              = each.value
  vpc_id                  = aws_vpc.aws_vpc.id
  availability_zone       = each.key
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name = "Public_Subnet_${each.key}"
  }
}

//---------------------------------------------------------------
//Private Subnet
resource "aws_subnet" "private_subnet" {
  depends_on        = [aws_vpc.aws_vpc]
  for_each          = var.private_subnet_cidr_block
  cidr_block        = each.value
  vpc_id            = aws_vpc.aws_vpc.id
  availability_zone = each.key

  tags = {
    Name = "Private_Subnet_${each.key}"
  }
}

//---------------------------------------------------------------
//Public route table
resource "aws_route_table" "public_route_table" {
  depends_on = [aws_vpc.aws_vpc, aws_internet_gateway.aws_gateway]

  vpc_id = aws_vpc.aws_vpc.id

  route {
    cidr_block = var.public_route_table_destination_cidr_block
    gateway_id = aws_internet_gateway.aws_gateway.id
  }

  tags = {
    Name = var.public_route_table_name
  }
}

//---------------------------------------------------------------
//Route Table association for public subnets
resource "aws_route_table_association" "public_subnet_public_route_table" {
  depends_on     = [aws_subnet.public_subnet, aws_route_table.public_route_table]
  route_table_id = aws_route_table.public_route_table.id
  for_each       = aws_subnet.public_subnet
  subnet_id      = each.value.id
}

//---------------------------------------------------------------
//Private route table
resource "aws_route_table" "private_route_table" {
  depends_on = [aws_vpc.aws_vpc, aws_internet_gateway.aws_gateway]

  vpc_id = aws_vpc.aws_vpc.id

  tags = {
    Name = var.private_route_table_name
  }
}

//---------------------------------------------------------------
//Route Table association for private subnets
resource "aws_route_table_association" "private_subnet_private_route_table" {
  depends_on     = [aws_subnet.private_subnet, aws_route_table.private_route_table]
  route_table_id = aws_route_table.private_route_table.id
  for_each       = aws_subnet.private_subnet
  subnet_id      = each.value.id
}









