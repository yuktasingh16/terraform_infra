data "aws_caller_identity" "current" {}

resource "aws_iam_openid_connect_provider" "github_actions" {

  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1"
  ]

}

data "aws_iam_policy_document" "github_actions_assume_role" {

  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    principals {
      type = "Federated"

      identifiers = [
        aws_iam_openid_connect_provider.github_actions.arn
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"

      values = [
        "sts.amazonaws.com"
      ]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"

      values = [
        "repo:${var.github_repository}:*"
      ]
    }
  }

}

resource "aws_iam_role" "github_actions_terraform" {

  name = var.github_actions_role_name

  assume_role_policy = data.aws_iam_policy_document.github_actions_assume_role.json

  tags = {
    Name        = var.github_actions_role_name
    Environment = "shared"
  }

}

data "aws_iam_policy_document" "github_actions_terraform_state" {

  statement {
    sid    = "ReadTerraformStateBucketLocation"
    effect = "Allow"

    actions = [
      "s3:GetBucketLocation"
    ]

    resources = [
      aws_s3_bucket.terraform_state.arn
    ]
  }

  statement {
    sid    = "ListTerraformStateBucketPrefix"
    effect = "Allow"

    actions = [
      "s3:ListBucket"
    ]

    resources = [
      aws_s3_bucket.terraform_state.arn
    ]

    condition {
      test     = "StringLike"
      variable = "s3:prefix"

      values = [
        "terraform",
        "terraform/",
        "terraform/*"
      ]
    }
  }

  statement {
    sid    = "ReadWriteTerraformStateObjects"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]

    resources = [
      "${aws_s3_bucket.terraform_state.arn}/terraform/*.tfstate"
    ]
  }

  statement {
    sid    = "ReadWriteTerraformLockFiles"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      "${aws_s3_bucket.terraform_state.arn}/terraform/*.tfstate.tflock"
    ]
  }

}

resource "aws_iam_policy" "github_actions_terraform_state" {

  name = "${var.github_actions_role_name}-state-backend"

  description = "Allows GitHub Actions Terraform jobs to use the S3 state backend."

  policy = data.aws_iam_policy_document.github_actions_terraform_state.json

}

resource "aws_iam_role_policy_attachment" "github_actions_terraform_state" {

  role = aws_iam_role.github_actions_terraform.name

  policy_arn = aws_iam_policy.github_actions_terraform_state.arn

}
