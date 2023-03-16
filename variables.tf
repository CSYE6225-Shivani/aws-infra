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
variable "count_subnets" {
  type        = number
  description = "Count of subnets to be created"
}

variable "subnet_mask" {
  type        = number
  description = "subnet_mask for subnet CIDR blocks"
}

variable "cidr_offset_for_private_subnet" {
  type        = number
  description = "offset to calculate the subnet mask for private subnets passed in cidrsubnet function"
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
  type        = string
  description = "Name of Private Route Table"
}

//---------------------------------------------------------------
//Variables for security group
variable "app_security_group_name" {
  type        = string
  description = "Name of security group"
}

variable "application_port" {
  type        = number
  description = "Port on which application runs"
}

//---------------------------------------------------------------
//Variables for EC2 instance
variable "custom_ami_id" {
  type        = string
  description = "ID of custom AMI created"
}

variable "instance_type" {
  type        = string
  description = "Instance Type"
}

variable "delete_on_termination" {
  type        = bool
  description = "Flag for protect against accidental termination"
}

variable "public_key" {
  type        = string
  description = "Public key for EC2 access"
}

variable "ec2_name" {
  type        = string
  description = "EC2 Instance name"
}

variable "disable_api_termination" {
  type        = bool
  description = "Protect against accidental termination"
}

variable "ec2_key_name" {
  type        = string
  description = "ec2 key Name"
}

variable "aws_instance_vol_size" {
  type        = number
  description = "aws_instance_volume_size"
}

variable "aws_instance_vol_type" {
  type        = string
  description = "aws_instance_volume_type"
}

//----------------------------------------------------------------
//Variables for Database Security Group
variable "db_security_group_name" {
  type        = string
  description = "DB security group name"
}
//----------------------------------------------------------------
//Variables for S3
variable "s3_bucket_tag" {
  type        = string
  description = "S3 bucket tag"
}

variable "s3_force_destroy" {
  type        = bool
  description = "S3 force destroy flag"
}

variable "s3_acl" {
  type        = string
  description = "S3 ACL - set to private"
}

variable "s3_default_encryption" {
  type        = string
  description = "s3_default_encryption - set to AES256"
}

variable "s3_storage_class" {
  type        = string
  description = "Lifecycle s3 storage class"
}

variable "s3_lifecycle_enable_status" {
  type        = string
  description = "s3_lifecycle_enable_status"
}

variable "block_public_acls" {
  type        = bool
  description = "block_public_acls"
}

variable "block_public_policy" {
  type        = bool
  description = "block_public_policy"
}

variable "ignore_public_acls" {
  type        = bool
  description = "ignore_public_acls"
}

variable "restrict_public_buckets" {
  type        = bool
  description = "restrict_public_buckets"
}

//----------------------------------------------------------------
//Variables for RDS Parameter Group
variable "db_family" {
  type        = string
  description = "Database family"
}

//----------------------------------------------------------------
//Variables for DB Instance
variable "db_instance" {
  type        = string
  description = "DB Instance Class"
}

variable "db_engine" {
  type        = string
  description = "DB engine"
}

variable "db_engine_version" {
  type        = string
  description = "DB engine version"
}

variable "db_allocated_storage" {
  type        = number
  description = "Allocated storage"
}

variable "db_mutli_az" {
  type        = bool
  description = "Multi-AZ deployment"
}

variable "db_identifier" {
  type        = string
  description = "DB Instance Identifier"
}

variable "db_master_username" {
  type        = string
  description = "Master username"
}

variable "db_master_password" {
  type        = string
  description = "Chavan@123"
}

variable "db_public_access" {
  type        = bool
  description = "Public Accessibility"
}

variable "db_name" {
  type        = string
  description = "db_name"
}

variable "db_AZ" {
  type        = string
  description = "DB Availability Zone"
}

variable "skip_final_snapshot" {
  type        = bool
  description = "skip_final_snapshot"
}

variable "db_port" {
  type        = number
  description = "Port number of POSTGRES"
}

variable "aws_db_instance_name" {
  type        = string
  description = "Name of aws_db_instance"
}

//----------------------------------------------------------------
//IAM
variable "ec2_iam_role" {
  type        = string
  description = "Name of EC2 IAM role"
}

variable "aws_iam_policy_name" {
  type        = string
  description = "aws_iam_policy_name"
}

variable "domain_name" {
  type        = string
  description = "aws_domain_name"
}

variable "route53_private_zone" {
  type        = bool
  description = "Route53 private hosted zone"
}

variable "route53_record_type" {
  type        = string
  description = "Record Type"
}

variable "ttl_value" {
  type        = number
  description = "TTL Value"
}

