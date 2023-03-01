resource "random_id" "s3_bucket_id" {
  byte_length = 8
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket        = "csye-6225-s3-${random_id.s3_bucket_id.hex}"
  force_destroy = var.s3_force_destroy

  tags = {
    "Name" = var.s3_bucket_tag
  }
}

resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  depends_on = [aws_s3_bucket.s3_bucket]
  bucket     = aws_s3_bucket.s3_bucket.id
  acl        = var.s3_acl
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_default_encryption" {
  depends_on = [aws_s3_bucket.s3_bucket]
  bucket     = aws_s3_bucket.s3_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.s3_default_encryption
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
      storage_class = var.s3_storage_class
    }
    status = var.s3_lifecycle_enable_status
  }
}

resource "aws_s3_bucket_public_access_block" "s3_bucket_public_access" {
  depends_on = [aws_s3_bucket.s3_bucket]
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}