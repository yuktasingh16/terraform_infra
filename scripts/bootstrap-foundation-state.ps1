param(
  [string]$Bucket = "letstype-terraform-state",
  [string]$Key = "terraform/foundation.tfstate",
  [string]$Region = "us-east-1"
)

$ErrorActionPreference = "Stop"

Write-Host "Checking whether foundation state exists at s3://$Bucket/$Key..."
$head = aws s3api head-object --bucket $Bucket --key $Key --region $Region 2>$null
if ($LASTEXITCODE -eq 0) {
  Write-Host "Foundation state already exists."
  exit 0
}

Write-Host "Foundation state not found. Create it by applying the foundation Terraform stack first."
Write-Host "Example:"
Write-Host "  Set-Location terraform/foundation"
Write-Host "  terraform init"
Write-Host "  terraform apply"
