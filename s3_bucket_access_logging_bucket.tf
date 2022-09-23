#tfsec:ignore:aws-s3-enable-versioning
#tfsec:ignore:aws-s3-enable-bucket-logging
resource "aws_s3_bucket" "access_logs" {
  bucket        = "${data.aws_caller_identity.current.account_id}-${aws_iam_account_alias.account_alias.account_alias}-s3-access-logs"
  force_destroy = true

}

#tfsec:ignore:aws-s3-encryption-customer-key
resource "aws_s3_bucket_server_side_encryption_configuration" "access_logs" {
  bucket = aws_s3_bucket.access_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "access_logs" {
  bucket                  = aws_s3_bucket.access_logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}