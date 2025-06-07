module "vpc" {
  source = "../modules/vpc"

  aws_region          = "eu-west-1"
  vpc_cidr           = "10.0.0.0/16"
  multi_az           = true
  nat_gateway_strategy = "multiple"
  environment        = "prod"
  
  tags = {
    Project     = "example-project"
    Environment = "production"
  }
} 