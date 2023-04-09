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

//----------------------------------------------------------------
//Route53

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

//----------------------------------------------------------------
//Load Balancer

variable "lb_name" {
  type        = string
  description = "Load Balancer Name"
}

variable "load_balancer_security_group" {
  type        = string
  description = "Load Balancer Security Group Name"
}

variable "load_balancer_internal" {
  type        = bool
  description = "load_balancer_internal"
}

variable "load_balancer_type" {
  type        = string
  description = "Load Balancer Type"
}

variable "lb_ip_address_type" {
  type        = string
  description = "IP address Type"
}

//----------------------------------------------------------------
//Listener
variable "lb_listener_port" {
  type        = string
  description = "lb_listener_port"
}

variable "lb_listener_protocol" {
  type        = string
  description = "lb_listener_protocol"
}

variable "lb_listener_default_type" {
  type        = string
  description = "lb_listener_default_type"
}

//----------------------------------------------------------------
//Launch Template
variable "launch_template_name" {
  type        = string
  description = "Launch Template Name"
}

variable "launch_template_description" {
  type        = string
  description = "Launch Template Description"
}

//----------------------------------------------------------------
//Autoscaling group

variable "asg_min" {
  type        = number
  description = "Min auto scaling group"
}

variable "asg_max" {
  type        = number
  description = "Max auto scaling group"
}

variable "asg_desired_capacity" {
  type        = number
  description = "ASG desired Capacity"
}

variable "asg_cooldown" {
  type        = string
  description = "ASG cooldown"
}

variable "device_name" {
  type        = string
  description = "Device name"
}

variable "associate_public_ip" {
  type        = bool
  description = "Associate public IP address"
}

variable "asg_name" {
  type        = string
  description = "Name of Autoscaling group"
}

variable "asg_propagate_at_launch" {
  type        = bool
  description = "propagate_at_launch"
}

variable "asg_tag_key" {
  type        = string
  description = "Tag key name"
}

variable "asg_tag_value" {
  type        = string
  description = "Tag key Value"
}

//----------------------------------------------------------------
//Target group variables

variable "lb_target_group_name" {
  type        = string
  description = "Name of load balancer target group"
}

variable "target_group_port" {
  type        = number
  description = "Target Group Port"
}

variable "target_type" {
  type        = string
  description = "target_type"
}

variable "target_group_protocol" {
  type        = string
  description = "Target Group Protocol"
}

variable "target_group_path" {
  type        = string
  description = "Target group path"
}

variable "target_group_matcher" {
  type        = number
  description = "Target Group Matcher"
}

variable "target_group_healthy" {
  type        = number
  description = "Target Group Healthy Threshold"
}

variable "target_group_unhealthy" {
  type        = number
  description = "Target Group unhealthy Threshold"
}

variable "target_group_interval" {
  type        = number
  description = "Target Group Interval"
}

variable "target_group_timeout" {
  type        = number
  description = "Target Group Timeout"
}

//----------------------------------------------------------------
//Scale Out Policy
variable "autoscaling_policy_name_scale_out" {
  type        = string
  description = "Autoscaling Scale Out Policy"
}

variable "scaling_adjustment_scale_out" {
  type        = number
  description = "Scaling_adjustment"
}

//----------------------------------------------------------------
//Scale In Policy
variable "autoscaling_policy_name_scale_in" {
  type        = string
  description = "Autoscaling Scale Out Policy"
}

variable "scaling_adjustment_scale_in" {
  type        = number
  description = "Scaling_adjustment"
}

//Common for scale-in & scale-out
variable "auto_scaling_policy_cooldown" {
  type        = number
  description = "Auto scaling policy scale out cooldown"
}

variable "adjustment_type" {
  type        = string
  description = "Adjustment Type"
}

//CloudWatch Metric Alarm Scale Out variables
variable "metric_alarm_name_so" {
  type        = string
  description = "Scale out metric alarm name"
}

variable "metric_alarm_threshold_so" {
  type        = string
  description = "Metric_alarm_threshold"
}

variable "metric_alarm_description_so" {
  type        = string
  description = "Metric Alarm Description"
}

variable "metric_alarm_comparision_operator_so" {
  type        = string
  description = "Metric Alarm Comparision Alarm"
}


//CloudWatch Metric Alarm Scale In variables
variable "metric_alarm_name_si" {
  type        = string
  description = "Scale out metric alarm name"
}

variable "metric_alarm_threshold_si" {
  type        = string
  description = "Metric_alarm_threshold"
}

variable "metric_alarm_description_si" {
  type        = string
  description = "Metric Alarm Description"
}

variable "metric_alarm_comparision_operator_si" {
  type        = string
  description = "Metric Alarm Comparision Alarm"
}

//Common for metric Alarms
variable "metric_alarm_evaluation_periods" {
  type        = string
  description = "Metric Alarm evaluation periods"
}

variable "metric_alarm_namespace" {
  type        = string
  description = "Metric Alarm Namespace"
}

variable "metric_alarm_period" {
  type        = string
  description = "Metric_alarm_period"
}

variable "metric_alarm_statistic" {
  type        = string
  description = "Metric_alarm_statistic"
}

variable "metric_name" {
  type        = string
  description = "Metric name"
}

//----------------------------------------------------------------
//SSL

variable "certificate_arn" {
  type        = string
  description = "Certificate ARN"
}
