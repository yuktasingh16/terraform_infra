# Deployment flow

This repository uses a split Terraform architecture with three independent roots:

- Foundation: provisions networking, IAM, and ECR.
- Platform: provisions EKS and the node group.
- Database: provisions RDS.

## Execution order

1. Foundation is applied first.
2. Platform runs after Foundation completes successfully.
3. Database runs after Foundation completes successfully.

## CI/CD behavior

- Pull requests validate each Terraform root independently.
- Foundation CD applies the foundation stack on pushes to main.
- Platform CD and Database CD are triggered by Foundation CD completion and by direct pushes when no foundation change is involved.
- Platform and Database CD skip direct push runs when the same push also changes foundation resources so that Foundation CD can complete first.

## State layout

Each Terraform root stores state in a separate S3 key:

- terraform/foundation.tfstate
- terraform/platform.tfstate
- terraform/database.tfstate

All roots use the same S3 bucket and DynamoDB lock table for state management.
