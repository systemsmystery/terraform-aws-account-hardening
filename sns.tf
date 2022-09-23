resource "aws_sns_topic" "cis_sns_topic" {
  name              = "CIS-SNS-Topic"
  kms_master_key_id = "alias/aws/sns"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.cis_sns_topic.arn
  protocol  = "email"
  endpoint  = var.sns_email
}