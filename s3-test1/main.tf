# Terraform configuration

provider "aws" {
  version = "~> 4.0"
  region  = "us-east-1"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "my-tf-test-bucket1234"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}