terraform {

  required_version = "1.4.6"

  required_providers {

    aws = {

      source = "hashicorp/aws"

      version = "5.2.0"

    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
}
