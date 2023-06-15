terraform {
  required_version = "1.4.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.2.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my-test-bucket" {
  bucket = "my-tf-test-bucket-1534458r9433498334"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
    ManagedBy   = "Terraform"
    Owner       = "Henrique Dias"
    UpdatedAt   = "2023-06-11"
  }
}