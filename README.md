# Infrastructure as Code with Terraform
This guide provides an overview of how to create network infrastructure using Terraform. We'll create a Virtual Private Cloud (VPC) with associated public and private subnets, configure route tables, and attach an Internet Gateway for public internet access.

## Prerequisites
Before getting started, make sure you have the following:

## Install Terraform:
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

## AWS Resources
---------------------------------------------------------
## Virtual Private Cloud (VPC)
Created a new VPC named "myVPC" with specified CIDR block.

## Internet Gateway
Created a new Internet Gateway named "myInternetGateway" and attached it to the VPC.

## Availability Zones
Queried and obtained the first three availability zones.

## Subnets
Created public and private subnets in each availability zone.
Associated route tables with subnets.

## Route Tables
Created public and private route tables.
Associated subnets with route tables.

## Security Groups
Created security groups for load balancer, EC2 instances, and RDS instance.

## RDS (Relational Database Service)
Created a MySQL RDS instance with specified configurations.

## IAM (Identity and Access Management)
Created an IAM role with policies for EC2 instances.
Attached policies for CloudWatch and S3 to the role.

## Load Balancer
Created an Application Load Balancer with specified configurations.
Configured listeners and target groups.

## Auto Scaling
Created an Auto Scaling Group with scaling policies and CloudWatch alarms.

## AWS Lambda
Created an IAM role and attached policies for Lambda function.
Defined and created an AWS Lambda function with dependencies on S3 bucket.

## SNS (Simple Notification Service)
Created an SNS topic and subscription for Lambda function.

## AWS CloudWatch Alarms
Created CloudWatch alarms for scaling based on CPU utilization.

## Route53
Created a Route53 record for the load balancer.

## AWS DynamoDB
Created a DynamoDB table with specified attributes and global secondary indexes.
Configured an IAM policy for DynamoDB access and attached it to the Lambda execution role.

## AWS S3
Created an S3 bucket with private ACL.



--------------------------------------------------------------------



# aws-infra
---------------------------
# _Assignment 3_
## Configure AWS CLI:
Install and configure AWS CLI from the following link:
https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html

## Install Terraform:
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

----------------

## Build Instructions:
1. Clone the repository

    git clone git@github.com:Shivani31996/aws-infra.git  


2. Create a .tfvars file which will contain all variable values
3. Format the files using `terraform fmt`
3. Initialize Terraform in the clone by running `terraform init`
3. Run `terraform plan` to validate infrastructure being created
4. Run `terraform apply -var-file="tfvar file name with extension"`
5. Run `terraform destroy` to destroy the resources

---------
# _**Assignment 4**_
1. With the generated AMI ID, edit terraform.tfvars.demo and change the AMI ID


2. Run below command to launch EC2 instance on generated AMI

   `terraform apply -var-file="terraform.tfvars.demo"`


3. Test all API endpoints are working using the public IP of EC2 instance


4. Reboot the EC2 instance 


5. Test all API endpoints


6. Run below command to destroy resources

   `terraform destroy -var-file="terraform.tfvars.demo"`

# _Assignment 5_
1. With the generated AMI ID, edit terraform.tfvars.demo and change the AMI ID


2. Run below command to launch EC2 instance on generated AMI

   `terraform apply -var-file="terraform.tfvars.demo"`


3. Test all API endpoints are working using the public IP of EC2 instance


4. Reboot the EC2 instance


5. Test all API endpoints


6. Run below command to destroy resources

   `terraform destroy -var-file="terraform.tfvars.demo"`

API Endpoints:

Upload Image
1. http://{{host}}:8080/v1/product/1/image

Get Specific Image Details
2. http://{{host}}:8080/v1/product/1/image/1

Get All img Details for a Product
3. http://{{host}}:8080/v1/product/1/image

Delete Image for a Product
4. http://{{host}}:8080/v1/product/1/image/


---------
## **_Assignment 07:_**
Attached CloudWatchAgentServerPolicy to EC2-CSYE6225 role for log group & log stream to get created.

## **_Assignment 08:_**
1. Created a security group for load balancer
2. Commented out EC2 resource creation
3. Created AutoScaling Group
4. Created Load Balancer
5. Created Alarms

