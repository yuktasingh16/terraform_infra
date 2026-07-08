# Bootstrap foundation Terraform state

The platform Terraform configuration reads outputs from the foundation stack through a remote state data source.

To make the platform plan work, the foundation stack must first be applied so that the state object exists in S3 at:

- bucket: `letstype-terraform-state`
- key: `terraform/foundation.tfstate`

## Local bootstrap steps

From the repository root:

```powershell
Set-Location terraform/foundation
terraform init
terraform apply
```

If you want to verify that the state object exists before running platform CI, use:

```powershell
pwsh -File scripts/bootstrap-foundation-state.ps1
```

This script checks whether the expected S3 object already exists and prints the next step if it does not.
