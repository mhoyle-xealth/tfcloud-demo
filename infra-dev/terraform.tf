# state s3
terraform {
  required_version = "~>0.12.0"

  backend "s3" {
    encrypt        = "true"
    bucket         = "xealth-demo-tfstate"
    key            = "staging/infra-dev/terraform.tfstate"
    region         = "us-east-1"
  }
}

