//EC2 instance
resource "aws_key_pair" "ec2_access" {
  key_name   = "ec2-terraform"
  public_key = var.public_key

  tags = {
    "Name" = "EC2 AWS Key Pair"
  }
}

data "aws_subnet_ids" "subnetIDs" {
  depends_on = [aws_vpc.aws_vpc, aws_subnet.public_subnets]
  vpc_id     = aws_vpc.aws_vpc.id

  filter {
    name   = "tag:Name"
    values = ["*Public*"]
  }
}

output "subnet_ids" {
  value = [element(tolist(data.aws_subnet_ids.subnetIDs.ids), 0),
    element(tolist(data.aws_subnet_ids.subnetIDs.ids), 1),
    element(tolist(data.aws_subnet_ids.subnetIDs.ids), 2)]
}

resource "aws_instance" "application-ec2" {
  depends_on              = [aws_key_pair.ec2_access, aws_vpc.aws_vpc, aws_security_group.application-sg,aws_db_instance.postgres_database]
  ami                     = var.custom_ami_id
  instance_type           = var.instance_type
  vpc_security_group_ids  = [aws_security_group.application-sg.id]
  key_name                = aws_key_pair.ec2_access.key_name
  subnet_id               = element(tolist(data.aws_subnet_ids.subnetIDs.ids), 0)
  disable_api_termination = var.disable_api_termination

  root_block_device {
    volume_size           = 50
    volume_type           = "gp2"
    delete_on_termination = var.delete_on_termination
  }

  user_data = <<EOF
#!/bin/bash

cd /etc/profile.d
touch parameters.sh
echo export HOST_NAME=${aws_db_instance.postgres_database.address} >> parameters.sh
echo export DB_PORT=${var.db_port} >> parameters.sh
echo export API_PORT=${var.application_port} >> parameters.sh
echo export DB_NAME=${var.db_name} >> parameters.sh
echo export DB_USERNAME=${var.db_master_username} >> parameters.sh
echo export DB_PASSWORD=${var.db_master_password} >> parameters.sh

cd /etc/systemd/system
touch service.env
echo HOST_NAME=${aws_db_instance.postgres_database.address} >> service.env
echo DB_PORT=${var.db_port} >> service.env
echo API_PORT=${var.application_port} >> service.env
echo DB_NAME=${var.db_name} >> service.env
echo DB_USERNAME=${var.db_master_username} >> service.env
echo DB_PASSWORD=${var.db_master_password} >> service.env

systemctl daemon-reload
systemctl enable userWebApp.service
systemctl start userWebApp.service

EOF

  tags = {
    Name = var.ec2_name
  }
}