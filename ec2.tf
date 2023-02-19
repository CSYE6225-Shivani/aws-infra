//---------------------------------------------------------------
//EC2
resource "aws_key_pair" "ec2_access" {
  key_name = "ec2"
  public_key = var.public_key
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
  value = [element(tolist(data.aws_subnet_ids.subnetIDs.ids), 0),element(tolist(data.aws_subnet_ids.subnetIDs.ids), 1),element(tolist(data.aws_subnet_ids.subnetIDs.ids), 2)]
}

resource "aws_instance" "application-ec2" {
  depends_on = [aws_vpc.aws_vpc,aws_security_group.application-sg]
  ami = var.custom_ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.application-sg.id]
  key_name = aws_key_pair.ec2_access.key_name
  subnet_id = element(tolist(data.aws_subnet_ids.subnetIDs.ids), 0)

  root_block_device {
    volume_size = 50
    volume_type = "gp2"
    delete_on_termination = var.delete_on_termination
  }

  tags = {
    Name = var.ec2_name
  }
}