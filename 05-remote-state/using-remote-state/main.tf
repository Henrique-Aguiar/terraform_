terraform {

  required_version = "1.4.6"

  required_providers {

    aws = {

      source = "hashicorp/aws"

      version = "5.2.0"

    }
  }

  backend "s3" {
    bucket  = "tfstate-285552379206"
    key     = "dev/usando-remote-state/terraform.tfstate"
    region  = "us-east-1"
    profile = "default"
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}
