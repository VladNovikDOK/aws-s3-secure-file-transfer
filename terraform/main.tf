terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region  = "eu-west-2"
  profile = "default"
}
resource "aws_s3_bucket" "transfer_lab" {
  bucket = "vladnovikdok-aws-s3-transfer-lab"
  tags = {
    Project = "aws-s3-transfer-lab"
  }
}
