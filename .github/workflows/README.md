# Terraform GitHub Actions Workflows

This folder contains the Terraform CI/CD workflows for the infrastructure repository.

## Workflows

- Bootstrap CI: validates the bootstrap state backend stack.
- Foundation CI: validates foundation changes on pull requests and can run a cloud plan from the GitHub Actions "Run workflow" button.
- Platform CI: validates platform changes on pull requests and can run a cloud plan from the GitHub Actions "Run workflow" button.
- Database CI: validates database changes on pull requests and can run a cloud plan from the GitHub Actions "Run workflow" button.
- Terraform Deploy: applies foundation, platform, and database in order on pushes to main, or from the GitHub Actions "Run workflow" button.

## Notes

- The workflows use Terraform 1.15.7.
- All Terraform workflows require the AWS role secret named AWS_ROLE_ARN.
- Use the `github_actions_role_arn` output from the bootstrap stack as the value for `AWS_ROLE_ARN`.
- Database workflows require the DB password secret named DB_PASSWORD.
- Pull request CI runs Terraform init with `-backend=false`, then validates without AWS credentials.
- Manual CI runs and deploy runs use AWS OIDC through `AWS_ROLE_ARN`.
- Manual cloud-plan CI uploads only the text plan output, not the binary plan file.
- Deploy jobs use GitHub Environments named `terraform-foundation`, `terraform-platform`, and `terraform-database`. Add approval rules there if you want a manual gate before apply.
- Bootstrap creates the Terraform state bucket, lock table, GitHub OIDC provider, and GitHub Actions Terraform role. Run it before the automated deploy workflow and manage its state separately until the backend exists.
