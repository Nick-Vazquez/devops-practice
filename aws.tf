terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }

    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 4"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  access_key  = var.aws_access_key
  secret_key  = var.aws_secret_key
  region      = var.aws_region
}

variable "aws_access_key" {
    description = "AWS Access Key"
    type = string
    sensitive = true
}

variable "aws_secret_key" {
    description = "AWS Secret Key"
    type = string
    sensitive = true
}

variable "aws_region" {
    description = "AWS Region"
    type = string
    default = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-079db87dc4c10ac91"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  tags = {
    Name = "WebServerInstance"
  }

  user_data = <<-EOF
              #!/bin/bash
              echo -e "<h1>Hello, world! Nick</h1>" > index.html
              python3 -m http.server 8080
              EOF
}

variable "security_group_name" {
  description = "The name of the security group"
  type        = string
  default     = "terraform-example-instance"
}

resource "aws_security_group" "instance" {

  name = var.security_group_name

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
