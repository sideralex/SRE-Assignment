terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0"
}

provider "aws" {
  region = "eu-west-1"  # You can change this to your preferred region

  default_tags {
    tags = {
      Environment = "example"
      ManagedBy   = "terraform"
    }
  }
} 