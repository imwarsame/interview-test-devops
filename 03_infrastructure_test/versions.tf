
terraform {
  required_version = "=0.12.26" # force a specific version of terraform to prevent remote state problems
  required_providers {
    aws = "~> 2.70"
  }
}
