#Finding the available zones in provided region
data "aws_availability_zones" "available_zones" {
  state = "available"
}

//vpc definition
resource "aws_vpc" "aws_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.dns_host_names

  tags = {
    Name = var.vpc_name
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
resource "aws_subnet" "public_subnets" {
  depends_on              = [aws_vpc.aws_vpc]
  count                   = var.count_subnets
  vpc_id                  = aws_vpc.aws_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.aws_vpc.cidr_block, var.subnet_mask, count.index + 1)
  availability_zone       = data.aws_availability_zones.available_zones.names[count.index]
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name = "Public_Subnet_${count.index + 1}"
  }
}

//---------------------------------------------------------------
//Private Subnet
resource "aws_subnet" "private_subnets" {
  depends_on              = [aws_vpc.aws_vpc]
  count                   = var.count_subnets
  vpc_id                  = aws_vpc.aws_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.aws_vpc.cidr_block, var.subnet_mask, count.index + var.cidr_offset_for_private_subnet)
  availability_zone       = data.aws_availability_zones.available_zones.names[count.index]
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name = "Private_Subnet_${count.index + 1}"
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
  depends_on     = [aws_subnet.public_subnets, aws_route_table.public_route_table]
  count          = var.count_subnets
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
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
  depends_on     = [aws_subnet.private_subnets, aws_route_table.private_route_table]
  count          = var.count_subnets
  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
}

//---------------------------------------------------------------
//Application Security Group
resource "aws_security_group" "application-sg" {
  depends_on  = [aws_vpc.aws_vpc]
  name        = "application"
  description = "Setting ingress & egress rules"
  vpc_id      = aws_vpc.aws_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "application_port"
    from_port   = var.application_port
    protocol    = "tcp"
    to_port     = var.application_port
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.security_group_name
  }
}






