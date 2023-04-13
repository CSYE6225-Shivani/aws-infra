resource "aws_kms_key" "ec2_key" {
  description              = "Custom key for EC2"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  deletion_window_in_days  = 15

  policy = <<-EOF
{
        "Version": "2012-10-17",
        "Id": "key-default-1",
        "Statement": [
            {
                "Sid": "Enable IAM User Permissions",
                "Effect": "Allow",
                "Principal": {
                    "AWS": [
                        "arn:aws:iam::${var.account_id}:root"
                    ]
                },
                "Action": "kms:*",
                "Resource": "*"
            },
            {
                "Sid": "Allow service-linked role use of the customer managed key",
                "Effect": "Allow",
                "Principal": {
                    "AWS": "arn:aws:iam::${var.account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
                },
                "Action": [
                    "kms:Encrypt",
                    "kms:Decrypt",
                    "kms:ReEncrypt*",
                    "kms:GenerateDataKey*",
                    "kms:DescribeKey"
                ],
                "Resource": "*"
            },
            {
                "Sid": "Allow attachment of persistent resources",
                "Effect": "Allow",
                "Principal": {
                    "AWS": "arn:aws:iam::${var.account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
                },
                "Action": "kms:CreateGrant",
                "Resource": "*",
                "Condition": {
                    "Bool": {
                        "kms:GrantIsForAWSResource": "true"
                    }
                }
            }
        ]
    }
    EOF
}

resource "aws_kms_alias" "ec2_kms_key" {
  name          = "alias/ec2"
  target_key_id = aws_kms_key.ec2_key.key_id
}

resource "aws_kms_key" "rds_kms_key" {
  description              = "Custom key for RDS"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  deletion_window_in_days  = 15

  policy = <<-EOF
{
        "Version": "2012-10-17",
        "Id": "key-default-1",
        "Statement": [
            {
                "Sid": "Enable IAM User Permissions",
                "Effect": "Allow",
                "Principal": {
                    "AWS": [
                        "arn:aws:iam::${var.account_id}:root"
                    ]
                },
                "Action": "kms:*",
                "Resource": "*"
            },
            {
                "Sid": "Allow service-linked role use of the customer managed key",
                "Effect": "Allow",
                "Principal": {
                    "AWS": "arn:aws:iam::${var.account_id}:role/aws-service-role/rds.amazonaws.com/AWSServiceRoleForRDS"
                },
                "Action": [
                    "kms:Encrypt",
                    "kms:Decrypt",
                    "kms:ReEncrypt*",
                    "kms:GenerateDataKey*",
                    "kms:DescribeKey"
                ],
                "Resource": "*"
            },
            {
                "Sid": "Allow attachment of persistent resources",
                "Effect": "Allow",
                "Principal": {
                    "AWS": "arn:aws:iam::${var.account_id}:role/aws-service-role/rds.amazonaws.com/AWSServiceRoleForRDS"
                },
                "Action": "kms:CreateGrant",
                "Resource": "*",
                "Condition": {
                    "Bool": {
                        "kms:GrantIsForAWSResource": "true"
                    }
                }
            }
        ]
    }
    EOF
}

resource "aws_kms_alias" "rds_kms_key" {
  target_key_id = aws_kms_key.rds_kms_key.key_id
  name          = "alias/rds"
}