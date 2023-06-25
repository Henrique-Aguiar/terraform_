variable "environment" {
  default     = "dev"
  type        = string
  description = ""
}

variable "aws_region" {
  default     = "us-east-1"
  type        = string
  description = ""
}

variable "aws_profile" {
  default     = "default"
  type        = string
  description = ""
}

variable "instance_ami" {
  default     = "ami-053b0d53c279acc90"
  type        = string
  description = ""
}

variable "instance_type" {
  default     = "t2.micro"
  type        = string
  description = ""
}

variable "instance_tags" {
  type        = map(string)
  description = ""
  default = {
    "Name"    = "Ubuntu"
    "Project" = "AWS com Terraform"
    "env"     = "prod"
  }
}