variable "master_account_id" {
  description = "The ID of the master account"
  type        = string
}

variable "account_alias" {
  description = "The alias to set the account to"
  type = string
}

variable "sns_email" {
  description = "The email address to send SNS notifications to"
  type = string
}