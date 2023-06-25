terraform {

  required_version = "1.4.6"

  required_providers {

    aws = {

      source = "hashicorp/aws"

      version = "5.2.0"

    }
  }

  # backend "s3" {
  #   bucket = "mybucket"
  #   key    = "path/to/my/key"
  #   region = "us-east-1"
  # }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

data "aws_caller_identity" "current" {

}

resource "aws_s3_bucket" "remote_state" {

  bucket = "tfstate-${data.aws_caller_identity.current.account_id}"

  tags = {
    description = "Store terraform remote state files"
    Owner       = local.common_tags.Owner
    ManagedBy   = local.common_tags.ManagedBy
  }

}

resource "aws_s3_bucket_versioning" "remote_state" {
  bucket = aws_s3_bucket.remote_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

output "aws_s3_bucket_remote_state" {
  value = aws_s3_bucket.remote_state.arn
}

output "name_remote_state" {
  value = aws_s3_bucket.remote_state.bucket
}