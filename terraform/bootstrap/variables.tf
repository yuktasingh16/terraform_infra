variable "aws_region" {

  description = "AWS Region"

  type = string

  default = "us-east-1"

}

variable "github_repository" {

  description = "GitHub repository allowed to assume the Terraform deploy role, in owner/name format."

  type = string

  default = "yuktasingh16/terraform_infra"

}

variable "github_actions_role_name" {

  description = "IAM role name used by GitHub Actions for Terraform CI/CD."

  type = string

  default = "letstype-github-actions-terraform"

}
