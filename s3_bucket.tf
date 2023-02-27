resource "random_id" "s3_bucket_id" {
  byte_length = 8
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket        = "csye-6225-s3-${random_id.s3_bucket_id.hex}"
  force_destroy = true

  tags = {
    "Name" = var.s3_bucket_tag
  }
}

resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  depends_on = [aws_s3_bucket.s3_bucket]
  bucket     = aws_s3_bucket.s3_bucket.id
  acl        = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_default_encryption" {
  depends_on = [aws_s3_bucket.s3_bucket]
  bucket     = aws_s3_bucket.s3_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "s3_bucket_lifecycle_config" {
  depends_on = [aws_s3_bucket.s3_bucket]
  bucket     = aws_s3_bucket.s3_bucket.id

  rule {
    id = "transition_policy"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    status = "Enabled"
  }
}
