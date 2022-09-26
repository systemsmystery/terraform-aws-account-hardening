module "config-ap-northeast-1" {
  source           = "git@github.com:systemsmystery/terraform-aws-config-enable-module.git"
  iam_role_arn     = aws_iam_role.config.arn
  config_bucket_id = aws_s3_bucket.config_bucket.id
  region           = "ap-northeast-1"
}

module "config-ap-northeast-2" {
  source           = "git@github.com:systemsmystery/terraform-aws-config-enable-module.git"
  iam_role_arn     = aws_iam_role.config.arn
  config_bucket_id = aws_s3_bucket.config_bucket.id
  region           = "ap-northeast-2"
}

module "config-ap-northeast-3" {
  source           = "git@github.com:systemsmystery/terraform-aws-config-enable-module.git"
  iam_role_arn     = aws_iam_role.config.arn
  config_bucket_id = aws_s3_bucket.config_bucket.id
  region           = "ap-northeast-3"
}

module "config-ap-south-1" {
  source           = "git@github.com:systemsmystery/terraform-aws-config-enable-module.git"
  iam_role_arn     = aws_iam_role.config.arn
  config_bucket_id = aws_s3_bucket.config_bucket.id
  region           = "ap-south-1"
}

module "config-ap-southeast-1" {
  source           = "git@github.com:systemsmystery/terraform-aws-config-enable-module.git"
  iam_role_arn     = aws_iam_role.config.arn
  config_bucket_id = aws_s3_bucket.config_bucket.id
  region           = "ap-southeast-1"
}

module "config-ap-southeast-2" {
  source           = "git@github.com:systemsmystery/terraform-aws-config-enable-module.git"
  iam_role_arn     = aws_iam_role.config.arn
  config_bucket_id = aws_s3_bucket.config_bucket.id
  region           = "ap-southeast-2"
}

# module "config-ap-southeast-3" {
#   source = "git@github.com:systemsmystery/terraform-aws-config-enable-module.git"
# iam_role_arn = aws_iam_role.config.arn
# config_bucket_id = aws_s3_bucket.config_bucket.id
#   region = "ap-southeast-3"
# }

module "config-ca-central-1" {
  source           = "git@github.com:systemsmystery/terraform-aws-config-enable-module.git"
  iam_role_arn     = aws_iam_role.config.arn
  config_bucket_id = aws_s3_bucket.config_bucket.id
  region           = "ca-central-1"
}

module "config-eu-central-1" {
  source           = "git@github.com:systemsmystery/terraform-aws-config-enable-module.git"
  iam_role_arn     = aws_iam_role.config.arn
  config_bucket_id = aws_s3_bucket.config_bucket.id
  region           = "eu-central-1"
}

module "config-eu-north-1" {
  source           = "git@github.com:systemsmystery/terraform-aws-config-enable-module.git"
  iam_role_arn     = aws_iam_role.config.arn
  config_bucket_id = aws_s3_bucket.config_bucket.id
  region           = "eu-north-1"
}

# module "config-eu-south-1" {
#   source = "git@github.com:systemsmystery/terraform-aws-config-enable-module.git"
# iam_role_arn = aws_iam_role.config.arn
# config_bucket_id = aws_s3_bucket.config_bucket.id
#   region = "eu-south-1"
# }

module "config-eu-west-1" {
  source           = "git@github.com:systemsmystery/terraform-aws-config-enable-module.git"
  iam_role_arn     = aws_iam_role.config.arn
  config_bucket_id = aws_s3_bucket.config_bucket.id
  region           = "eu-west-1"
}

module "config-eu-west-2" {
  source           = "git@github.com:systemsmystery/terraform-aws-config-enable-module.git"
  iam_role_arn     = aws_iam_role.config.arn
  config_bucket_id = aws_s3_bucket.config_bucket.id
  region           = "eu-west-2"
}

module "config-eu-west-3" {
  source           = "git@github.com:systemsmystery/terraform-aws-config-enable-module.git"
  iam_role_arn     = aws_iam_role.config.arn
  config_bucket_id = aws_s3_bucket.config_bucket.id
  region           = "eu-west-3"
}

module "config-sa-east-1" {
  source           = "git@github.com:systemsmystery/terraform-aws-config-enable-module.git"
  iam_role_arn     = aws_iam_role.config.arn
  config_bucket_id = aws_s3_bucket.config_bucket.id
  region           = "sa-east-1"
}

module "config-us-east-1" {
  source           = "git@github.com:systemsmystery/terraform-aws-config-enable-module.git"
  iam_role_arn     = aws_iam_role.config.arn
  config_bucket_id = aws_s3_bucket.config_bucket.id
  region           = "us-east-1"
}

module "config-us-east-2" {
  source           = "git@github.com:systemsmystery/terraform-aws-config-enable-module.git"
  iam_role_arn     = aws_iam_role.config.arn
  config_bucket_id = aws_s3_bucket.config_bucket.id
  region           = "us-east-2"
}

module "config-us-west-1" {
  source           = "git@github.com:systemsmystery/terraform-aws-config-enable-module.git"
  iam_role_arn     = aws_iam_role.config.arn
  config_bucket_id = aws_s3_bucket.config_bucket.id
  region           = "us-west-1"
}

module "config-us-west-2" {
  source           = "git@github.com:systemsmystery/terraform-aws-config-enable-module.git"
  iam_role_arn     = aws_iam_role.config.arn
  config_bucket_id = aws_s3_bucket.config_bucket.id
  region           = "us-west-2"
}