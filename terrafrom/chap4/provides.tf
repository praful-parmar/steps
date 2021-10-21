#####/root/providers.tf#####

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = "us-east-1" #us-east-2 geeting authorization error
  access_key = "AKIASMT2DQTGNCOEPBYS"
  secret_key = "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"
}
