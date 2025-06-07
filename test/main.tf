provider "aws" {
  region = "eu-west-1"
}

# Test single AZ deployment
module "vpc_single_az" {
  source = "../modules/vpc"

  aws_region          = "eu-west-1"
  vpc_cidr           = "10.0.0.0/16"
  multi_az           = false
  nat_gateway_strategy = "single"
  environment        = "test"
  
  tags = {
    Test = "single-az"
  }
}

# Test multi AZ deployment
module "vpc_multi_az" {
  source = "../modules/vpc"

  aws_region          = "eu-west-1"
  vpc_cidr           = "10.0.0.0/16"
  multi_az           = true
  nat_gateway_strategy = "multiple"
  environment        = "test"
  
  tags = {
    Test = "multi-az"
  }
}

# Outputs for verification
output "single_az_public_subnet_cidrs" {
  value = module.vpc_single_az.public_subnet_ids
  description = "Single AZ public subnet CIDRs (should be one /24)"
}

output "single_az_private_subnet_cidrs" {
  value = module.vpc_single_az.private_subnet_ids
  description = "Single AZ private subnet CIDRs (should be one /19)"
}

output "multi_az_public_subnet_cidrs" {
  value = module.vpc_multi_az.public_subnet_ids
  description = "Multi AZ public subnet CIDRs (should be three /24)"
}

output "multi_az_private_subnet_cidrs" {
  value = module.vpc_multi_az.private_subnet_ids
  description = "Multi AZ private subnet CIDRs (should be three /19)"
} 