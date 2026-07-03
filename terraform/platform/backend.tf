terraform {
  backend "s3" {
    bucket       = "letstype-terraform-state"
    key          = "terraform/platform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}
