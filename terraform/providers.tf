provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project   = "aws-centralized-logging"
      ManagedBy = "Terraform"
    }
  }
}
