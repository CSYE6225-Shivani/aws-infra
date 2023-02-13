//Variables for provider
variable "profile" {
  type        = string
  description = "Profile to create AWS resources"
}

variable "region" {
  type        = string
  description = "Region to create AWS resources"
}

//---------------------------------------------------------------
//Variables for VPC
variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC"
}

variable "vpc_name" {
  type        = string
  description = "VPC_name"
}

//---------------------------------------------------------------
//Variables for Internet Gateway
variable "ig_name" {
  type        = string
  description = "Internet Gateway_name"
}

//---------------------------------------------------------------
//Variables for Subnets
variable "public_subnet_cidr_block" {
  type        = map(string)
  description = "CIDR block for public subnets"
  #  default = {
  #    "us-east-1a" = "10.0.0.0/19",
  #    "us-east-1b" = "10.0.64.0/18",
  #    "us-east-1c" = "10.0.192.0/19"
  #  }
}

variable "private_subnet_cidr_block" {
  type        = map(string)
  description = "CIDR block for private subnets"
  #  default = {
  #    "us-east-1a" = "10.0.32.0/19",
  #    "us-east-1b" = "10.0.128.0/18",
  #    "us-east-1c" = "10.0.224.0/19"
  #  }
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "True for Public subnets"
}

variable "dns_host_names" {
  type        = bool
  description = "True to enable DNS host names"
}

//---------------------------------------------------------------
//Variables for Public route table
variable "public_route_table_destination_cidr_block" {
  type        = string
  description = "Destination CIDR block (0.0.0.0/0)"
}

variable "public_route_table_name" {
  type        = string
  description = "Name of Public Route Table"
}

//---------------------------------------------------------------
//Variables for private route table
variable "private_route_table_name" {
  type = string
  description = "Name of Private Route Table"
}




