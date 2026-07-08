terraform {
  backend "s3" {
    bucket       = "letstype-terraform-state-793010745635"
    key          = "terraform/foundation.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}
