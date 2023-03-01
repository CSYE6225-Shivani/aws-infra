//------------------------------------------------
//EC2-CSYE6225 IAM role

resource "aws_iam_role" "EC2-CSYE6225" {
  name               = var.ec2_iam_role
  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal":
          {
            "Service": "ec2.amazonaws.com"
          },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
EOF
  tags = {
    "Name" = var.ec2_iam_role
  }
}

//------------------------------------------------
//IAM Policy WebAppS3
resource "aws_iam_policy" "WebAppS3" {
  name        = var.aws_iam_policy_name
  description = "IAM policy for EC2-S3 resource "
  policy      = <<-EOF
    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "sts:AssumeRole",
                "s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::${aws_s3_bucket.s3_bucket.id}",
                "arn:aws:s3:::${aws_s3_bucket.s3_bucket.id}/*"
            ]
        }
    ]
    }
    EOF

  tags = {
    "Name" = var.aws_iam_policy_name
  }
}

//------------------------------------------------
//EC2-CSYE6225 IAM role - WebAppS3 Policy Attachment
resource "aws_iam_role_policy_attachment" "EC2-CSYE6225-S3" {
  policy_arn = aws_iam_policy.WebAppS3.arn
  role       = aws_iam_role.EC2-CSYE6225.name
}

//------------------------------------------------
//EC2-CSYE6225  - Instance Profile for EC2
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.EC2-CSYE6225.name
}
