# Terraform configuration

provider "aws" {
  version = "~> 4.0"
  region  = "us-east-1"

  assume_role {
    role_arn     = "arn:aws:iam::880603951957:role/spacelift-admin"
    session_name = "spacelift"
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.21.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_nat_gateway = var.vpc_enable_nat_gateway

  tags = var.vpc_tags
}

module "ec2_instances" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.12.0"

  name           = "my-ec2-cluster-dev"
  instance_count = 1

  ami                    = "ami-0d7a59bc717a91d73"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "website_s3_bucket" {
  source  = "spacelift.io/xealth/aws-s3-static-website-bucket/aws"
  version = ">= 0.1.0, < 0.2.0"

  bucket_name = "tfdemo-test-dev"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "website_s3_bucket_internal_module" {
  source  = "../modules/aws-s3-static-website-bucket"

  bucket_name = "tfdemo-test-dev-internal"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
