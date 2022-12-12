terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1",
  profile = "default"
}

resource "aws_instance" "app_server" {
  ami           = "ami-03c1fac8dd915ff60"
  instance_type = "t2.micro"

  tags = {
    Name = var.instance_name
  }
}