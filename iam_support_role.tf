resource "aws_iam_role" "support_role" {
  name = "CIS-Support-Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        AWS = var.master_account_id
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "support_access" {
  role       = aws_iam_role.support_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSSupportAccess"
}