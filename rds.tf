data "aws_subnet_ids" "public_subnet_ids" {
  depends_on = [aws_vpc.aws_vpc, aws_subnet.private_subnets]
  vpc_id     = aws_vpc.aws_vpc.id

  filter {
    name   = "tag:Name"
    values = ["*Private*"]
  }

  tags = {
    "Name" = "Private Subnet ID list for RDS"
  }
}

resource "aws_db_subnet_group" "private_subnet_list" {
  name = "private-subnet-list"
  subnet_ids = [element(tolist(data.aws_subnet_ids.private_subnet_ids.ids), 0),
    element(tolist(data.aws_subnet_ids.private_subnet_ids.ids), 1),
  element(tolist(data.aws_subnet_ids.private_subnet_ids.ids), 2)]

  tags = {
    Name = "Private Subnet List"
  }
}

resource "aws_db_parameter_group" "rds_parameter_group" {
  name        = "custom-parameter-group"
  family      = var.db_family
  description = "Custom Parameter Group"

  tags = {
    Name = "Custom RDS Parameter Group"
  }

}

resource "aws_db_instance" "postgres_database" {
  instance_class         = var.db_instance
  port                   = var.db_port
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  multi_az               = var.db_mutli_az
  identifier             = var.db_identifier
  username               = var.db_master_username
  password               = var.db_master_password
  db_subnet_group_name   = aws_db_subnet_group.private_subnet_list.id
  publicly_accessible    = var.db_public_access
  db_name                = var.db_name
  parameter_group_name   = aws_db_parameter_group.rds_parameter_group.id
  vpc_security_group_ids = [aws_security_group.database_security_group.id]
  allocated_storage      = var.db_allocated_storage
  skip_final_snapshot    = var.skip_final_snapshot

  tags = {
    "Name" = "CSYE6225-RDS-Instance"
  }
}

