# AWS VPC Terraform Module

This Terraform module creates a VPC with configurable networking components in AWS.

## Features

- Configurable AWS region
- Configurable VPC CIDR block (must be /16)
- Single or Multi-AZ deployment
  - Single AZ: 1 public subnet (/24) and 1 private subnet (/19)
  - Multi AZ: 3 public subnets (/24) and 3 private subnets (/19)
- Configurable NAT Gateway strategy
  - Single NAT Gateway
  - Multiple NAT Gateways (one per AZ)

## Usage

```hcl
module "vpc" {
  source = "./modules/vpc"

  aws_region          = "eu-west-1"
  vpc_cidr           = "10.0.0.0/16"
  multi_az           = true
  nat_gateway_strategy = "multiple"
  environment        = "prod"
  
  tags = {
    Project     = "my-project"
    Environment = "production"
  }
}
```

## Requirements

- Terraform >= 1.0
- AWS Provider >= 5.0

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws_region | AWS region to deploy resources | `string` | `"us-east-1"` | no |
| vpc_cidr | CIDR block for the VPC. Must be a /16 CIDR block | `string` | n/a | yes |
| multi_az | Whether to create resources in multiple AZs | `bool` | `false` | no |
| nat_gateway_strategy | Strategy for NAT Gateways. Options: 'single' or 'multiple' | `string` | `"single"` | no |
| environment | Environment name for tagging | `string` | `"dev"` | no |
| tags | Additional tags for all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | The ID of the VPC |
| vpc_cidr_block | The CIDR block of the VPC |
| public_subnet_ids | List of public subnet IDs |
| private_subnet_ids | List of private subnet IDs |
| nat_gateway_ids | List of NAT Gateway IDs |
| public_route_table_id | ID of the public route table |
| private_route_table_ids | List of private route table IDs |

## Notes

- The VPC CIDR block must be a /16 CIDR block (e.g., 10.0.0.0/16)
- In single AZ mode, resources are created in the first AZ of the specified region
- In multi AZ mode, resources are created in the first three AZs of the specified region
- Public subnets are created with /24 CIDR blocks
- Private subnets are created with /19 CIDR blocks 