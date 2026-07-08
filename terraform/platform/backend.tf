terraform {
  backend "s3" {
    bucket       = "letstype-terraform-state-793010745635"
    key          = "terraform/platform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}
