resource "aws_cloudwatch_log_metric_filter" "unauth" {
  name           = "unauthorized_api_calls_metric"
  pattern        = "{($.errorCode = \"*UnauthorizedOperation\") || ($.errorCode = \"AccessDenied*\")}"
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name

  metric_transformation {
    name      = "unauthorized_api_calls_metric"
    namespace = "CISBenchmark"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "unauth" {
  alarm_name          = "unauthorized_api_calls_alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "unauthorized_api_calls_metric"
  namespace           = "CISBenchmark"
  period              = 300
  statistic           = "Sum"
  threshold           = 1
  alarm_actions       = [aws_sns_topic.cis_sns_topic.arn]
}

resource "aws_cloudwatch_log_metric_filter" "nomfa" {
  name           = "no_mfa_console_signin_metric"
  pattern        = "{($.eventName = \"ConsoleLogin\") && ($.additionalEventData.MFAUsed != \"Yes\")}"
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name

  metric_transformation {
    name      = "no_mfa_console_signin_metric"
    namespace = "CISBenchmark"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "nomfa" {
  alarm_name          = "no_mfa_console_signin_alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "no_mfa_console_signin_metric"
  namespace           = "CISBenchmark"
  period              = 300
  statistic           = "Sum"
  threshold           = 1
  alarm_actions       = [aws_sns_topic.cis_sns_topic.arn]

}

resource "aws_cloudwatch_metric_alarm" "root" {
  alarm_name          = "root_usage_alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "root_usage_metric"
  namespace           = "CISBenchmark"
  period              = 300
  statistic           = "Sum"
  threshold           = 1
  alarm_actions       = [aws_sns_topic.cis_sns_topic.arn]
}

resource "aws_cloudwatch_log_metric_filter" "root" {
  name           = "root_usage_metric"
  pattern        = "{ $.userIdentity.type = \"Root\" && $.userIdentity.invokedBy NOT EXISTS && $.eventType != \"AwsServiceEvent\" }"
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name

  metric_transformation {
    name      = "root_usage_metric"
    namespace = "CISBenchmark"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "policychange" {
  alarm_name          = "iam_changes_alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "iam_changes_metric"
  namespace           = "CISBenchmark"
  period              = 300
  statistic           = "Sum"
  threshold           = 1
  alarm_actions       = [aws_sns_topic.cis_sns_topic.arn]
}

resource "aws_cloudwatch_log_metric_filter" "policychange" {
  name           = "iam_changes_metric"
  pattern        = <<PATTERN
   "($.eventName=DeleteGroupPolicy)||($.eventName=DeleteRolePolicy)||
    ($.eventName=DeleteUserPolicy)||($.eventName=PutGroupPolicy)||
    ($.eventName=PutRolePolicy)||($.eventName=PutUserPolicy)||
    ($.eventName=CreatePolicy)||($.eventName=DeletePolicy)||
    ($.eventName=CreatePolicyVersion)||($.eventName=DeletePolicyVersion)||
    ($.eventName=AttachRolePolicy)||($.eventName=DetachRolePolicy)||
    ($.eventName=AttachUserPolicy)||($.eventName=DetachUserPolicy)||
    ($.eventName=AttachGroupPolicy)||($.eventName=DetachGroupPolicy)}"
  PATTERN
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name

  metric_transformation {
    name      = "iam_changes_metric"
    namespace = "CISBenchmark"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "cloudtrail_cfg" {
  alarm_name          = "cloudtrail_cfg_changes_alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "cloudtrail_cfg_changes_metric"
  namespace           = "CISBenchmark"
  period              = 300
  statistic           = "Sum"
  threshold           = 1
  alarm_actions       = [aws_sns_topic.cis_sns_topic.arn]
}

resource "aws_cloudwatch_log_metric_filter" "cloudtrail_cfg" {
  name           = "cloudtrail_cfg_changes_metric"
  pattern        = "{($.eventName = CreateTrail) || ($.eventName = UpdateTrail) || ($.eventName = DeleteTrail) || ($.eventName = StartLogging) || ($.eventName = StopLogging)}"
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name

  metric_transformation {
    name      = "cloudtrail_cfg_changes_metric"
    namespace = "CISBenchmark"
    value     = "1"
  }
}

resource "aws_cloudwatch_log_metric_filter" "signfail" {
  name           = "console_signin_failure_metric"
  pattern        = "{($.eventName = \"ConsoleLogin\") && ($.errorMessage = \"Failed authentication\") }"
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name

  metric_transformation {
    name      = "console_signin_failure_metric"
    namespace = "CISBenchmark"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "signfail" {
  alarm_name          = "console_signin_failure_alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "console_signin_failure_metric"
  namespace           = "CISBenchmark"
  period              = 300
  statistic           = "Sum"
  threshold           = 1
  alarm_actions       = [aws_sns_topic.cis_sns_topic.arn]
}

resource "aws_cloudwatch_metric_alarm" "bucket_mod" {
  alarm_name          = "s3_bucket_policy_changes_alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "s3_bucket_policy_changes_metric"
  namespace           = "CISBenchmark"
  period              = 300
  statistic           = "Sum"
  threshold           = 1
  alarm_actions       = [aws_sns_topic.cis_sns_topic.arn]
}

resource "aws_cloudwatch_log_metric_filter" "bucket_mod" {
  name           = "s3_bucket_policy_changes_metric"
  pattern        = <<PATTERN
{($.eventSource = s3.amazonaws.com) && (($.eventName = PutBucketAcl) ||
($.eventName = PutBucketPolicy) || ($.eventName = PutBucketCors) ||
($.eventName = PutBucketLifecycle) || ($.eventName = PutBucketReplication) ||
($.eventName = DeleteBucketPolicy) || ($.eventName = DeleteBucketCors) ||
($.eventName = DeleteBucketLifecycle) || ($.eventName =DeleteBucketReplication)) }
PATTERN
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name

  metric_transformation {
    name      = "s3_bucket_policy_changes_metric"
    namespace = "CISBenchmark"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "config_change" {
  alarm_name          = "aws_config_changes_alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "aws_config_changes_metric"
  namespace           = "CISBenchmark"
  period              = 300
  statistic           = "Sum"
  threshold           = 1
  alarm_actions       = [aws_sns_topic.cis_sns_topic.arn]
}

resource "aws_cloudwatch_log_metric_filter" "config_change" {
  name           = "aws_config_changes_metric"
  pattern        = "{($.eventSource = config.amazonaws.com) && (($.eventName=StopConfigurationRecorder)||($.eventName=DeleteDeliveryChannel)|| ($.eventName=PutDeliveryChannel)||($.eventName=PutConfigurationRecorder))}"
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name

  metric_transformation {
    name      = "aws_config_changes_metric"
    namespace = "CISBenchmark"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "sg" {
  alarm_name          = "security_group_changes_alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "security_group_changes_metric"
  namespace           = "CISBenchmark"
  period              = 300
  statistic           = "Sum"
  threshold           = 1
  alarm_actions       = [aws_sns_topic.cis_sns_topic.arn]
}

resource "aws_cloudwatch_log_metric_filter" "sg" {
  name           = "security_group_changes_metric"
  pattern        = <<PATTERN
{($.eventName = AuthorizeSecurityGroupIngress) ||
($.eventName = AuthorizeSecurityGroupEgress) ||
($.eventName = RevokeSecurityGroupIngress) ||
($.eventName = RevokeSecurityGroupEgress) ||
($.eventName = CreateSecurityGroup) ||
($.eventName = DeleteSecurityGroup) }
  PATTERN
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name

  metric_transformation {
    name      = "security_group_changes_metric"
    namespace = "CISBenchmark"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "gateway" {
  alarm_name          = "gateway_changes_alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "gateway_changes_metric"
  namespace           = "CISBenchmark"
  period              = 300
  statistic           = "Sum"
  threshold           = 1
  alarm_actions       = [aws_sns_topic.cis_sns_topic.arn]
}

resource "aws_cloudwatch_log_metric_filter" "gateway" {
  name           = "gateway_changes_metric"
  pattern        = <<PATTERN
{ ($.eventName = CreateCustomerGateway) ||
($.eventName = DeleteCustomerGateway) || ($.eventName = AttachInternetGateway) ||
($.eventName = CreateInternetGateway) || ($.eventName = DeleteInternetGateway) ||
($.eventName = DetachInternetGateway) }
PATTERN
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name
  metric_transformation {
    name      = "gateway_changes_metric"
    namespace = "CISBenchmark"
    value     = "1"
  }
}

resource "aws_cloudwatch_log_metric_filter" "routes" {
  name           = "route_table_changes_metric"
  pattern        = <<PATTERN
{($.eventName = CreateRoute) || ($.eventName = CreateRouteTable) ||
($.eventName = ReplaceRoute) || ($.eventName = ReplaceRouteTableAssociation)||
($.eventName = DeleteRouteTable) || ($.eventName = DeleteRoute) ||
($.eventName = DisassociateRouteTable) }
PATTERN
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name

  metric_transformation {
    name      = "route_table_changes_metric"
    namespace = "CISBenchmark"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "routes" {
  alarm_name          = "route_table_changes_alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "route_table_changes_metric"
  namespace           = "CISBenchmark"
  period              = 300
  statistic           = "Sum"
  threshold           = 1
  alarm_actions       = [aws_sns_topic.cis_sns_topic.arn]
}

resource "aws_cloudwatch_log_metric_filter" "vpc" {
  name           = "vpc_changes_metric"
  pattern        = <<PATTERN
{ ($.eventName = CreateVpc) || ($.eventName = DeleteVpc) ||  ($.eventName = ModifyVpcAttribute) ||
  ($.eventName = AcceptVpcPeeringConnection) || ($.eventName = CreateVpcPeeringConnection) ||
  ($.eventName = DeleteVpcPeeringConnection) || ($.eventName = RejectVpcPeeringConnection) ||
  ($.eventName = AttachClassicLinkVpc) || ($.eventName = DetachClassicLinkVpc) ||
  ($.eventName = DisableVpcClassicLink) || ($.eventName = EnableVpcClassicLink) }
PATTERN
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name

  metric_transformation {
    name      = "vpc_changes_metric"
    namespace = "CISBenchmark"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "vpc" {
  alarm_name          = "vpc_changes_alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "vpc_changes_metric"
  namespace           = "CISBenchmark"
  period              = 300
  statistic           = "Sum"
  threshold           = 1
  alarm_actions       = [aws_sns_topic.cis_sns_topic.arn]
}

resource "aws_cloudwatch_metric_alarm" "nacl" {
  alarm_name          = "nacl_changes_alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "nacl_changes_metric"
  namespace           = "CISBenchmark"
  period              = 300
  statistic           = "Sum"
  threshold           = 1
  alarm_actions       = [aws_sns_topic.cis_sns_topic.arn]
}

resource "aws_cloudwatch_log_metric_filter" "nacl" {
  name           = "nacl_changes_metric"
  pattern        = <<PATTERN
{($.eventName = CreateNetworkAcl) ||
($.eventName = CreateNetworkAclEntry) ||
($.eventName = DeleteNetworkAcl) ||
($.eventName = DeleteNetworkAclEntry) ||
($.eventName = ReplaceNetworkAclEntry) ||
($.eventName = ReplaceNetworkAclAssociation) }
PATTERN
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name

  metric_transformation {
    name      = "nacl_changes_metric"
    namespace = "CISBenchmark"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "cmk" {
  alarm_name          = "disable_or_delete_cmk_changes_alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "disable_or_delete_cmk_changes_metric"
  namespace           = "CISBenchmark"
  period              = 300
  statistic           = "Sum"
  threshold           = 1
  alarm_actions       = [aws_sns_topic.cis_sns_topic.arn]
}

resource "aws_cloudwatch_log_metric_filter" "cmk" {
  name           = "disable_or_delete_cmk_changes_metric"
  pattern        = "{($.eventSource = kms.amazonaws.com) && (($.eventName=DisableKey)||($.eventName=ScheduleKeyDeletion)) }"
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name

  metric_transformation {
    name      = "disable_or_delete_cmk_changes_metric"
    namespace = "CISBenchmark"
    value     = "1"
  }
}