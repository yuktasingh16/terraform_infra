# Terraform GitHub Actions Workflows

This folder contains the Terraform CI/CD workflows for the infrastructure repository.

## Workflows

- Foundation CI: runs formatting, validation, planning, and PR comments for foundation changes.
- Foundation CD: applies the foundation stack on pushes to main.
- Platform CI: runs formatting, validation, planning, and PR comments for platform changes.
- Platform CD: applies the platform stack on pushes to main.
- Database CI: runs formatting, validation, planning, and PR comments for database changes.
- Database CD: applies the database stack on pushes to main.

## Notes

- The workflows assume the Terraform version used locally is 1.5.7.
- Database workflows require the DB password secret named DB_PASSWORD.
- GitHub Environments named terraform-foundation, terraform-platform, and terraform-database should be created in the repository settings before enabling apply workflows.
