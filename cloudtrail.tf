data "aws_caller_identity" "current" {}

#tfsec:ignore:aws-s3-enable-versioning
resource "aws_s3_bucket" "cloudtrail" {
  bucket        = "${data.aws_caller_identity.current.account_id}-${aws_iam_account_alias.account_alias.account_alias}-cloudtrail"
  force_destroy = true
}

resource "aws_s3_bucket_logging" "cloudtrail" {
  bucket = aws_s3_bucket.cloudtrail.id

  target_bucket = aws_s3_bucket.access_logs.id
  target_prefix = "${aws_s3_bucket.cloudtrail.id}/logs/"
}

#tfsec:ignore:aws-s3-encryption-customer-key
resource "aws_s3_bucket_server_side_encryption_configuration" "cloudtrail" {
  bucket = aws_s3_bucket.cloudtrail.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


resource "aws_s3_bucket_policy" "cloudtrail" {
  bucket = aws_s3_bucket.cloudtrail.id
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "${aws_s3_bucket.cloudtrail.arn}"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "${aws_s3_bucket.cloudtrail.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_public_access_block" "cloudtrail" {
  bucket                  = aws_s3_bucket.cloudtrail.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

#tfsec:ignore:aws-cloudwatch-log-group-customer-key
resource "aws_cloudwatch_log_group" "cloudtrail" {
  name              = "${data.aws_caller_identity.current.account_id}-${aws_iam_account_alias.account_alias.account_alias}-cloudtrail"
  retention_in_days = 14
}

resource "aws_iam_role" "cloudtrail_role" {
  name               = "${data.aws_caller_identity.current.account_id}-${aws_iam_account_alias.account_alias.account_alias}-cloudtrail-role"
  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}

data "aws_iam_policy_document" "cloudtrail_cloudwatch" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "${aws_cloudwatch_log_group.cloudtrail.arn}:*"
    ]
  }
}

resource "aws_iam_policy" "cloudtrail_cloudwatch" {
  name   = "${data.aws_caller_identity.current.account_id}-${aws_iam_account_alias.account_alias.account_alias}-cloudtrail-cloudwatch"
  policy = data.aws_iam_policy_document.cloudtrail_cloudwatch.json
}

resource "aws_iam_policy_attachment" "cloudtrail_cloudwatch" {
  name = "cloudtrail-cloudwatch"
  roles = [
    aws_iam_role.cloudtrail_role.name
  ]
  policy_arn = aws_iam_policy.cloudtrail_cloudwatch.arn
}

#tfsec:ignore:aws-cloudtrail-enable-at-rest-encryption
resource "aws_cloudtrail" "cloudtrail" {
  name                          = "${data.aws_caller_identity.current.account_id}-${aws_iam_account_alias.account_alias.account_alias}-cloudtrail"
  s3_bucket_name                = aws_s3_bucket.cloudtrail.id
  is_multi_region_trail         = true
  include_global_service_events = true
  enable_log_file_validation    = true
  cloud_watch_logs_group_arn    = "${aws_cloudwatch_log_group.cloudtrail.arn}:*"
  cloud_watch_logs_role_arn     = aws_iam_role.cloudtrail_role.arn
}