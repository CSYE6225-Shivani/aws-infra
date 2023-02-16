# aws-infra

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

