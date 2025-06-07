variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC. Must be a /16 CIDR block"
  type        = string

  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/16$", var.vpc_cidr))
    error_message = "VPC CIDR must be a /16 CIDR block (e.g., 10.0.0.0/16)"
  }
}

variable "multi_az" {
  description = "Whether to create resources in multiple AZs"
  type        = bool
  default     = false
}

variable "nat_gateway_strategy" {
  description = "Strategy for NAT Gateways. Options: 'single' or 'multiple'"
  type        = string
  default     = "single"

  validation {
    condition     = contains(["single", "multiple"], var.nat_gateway_strategy)
    error_message = "NAT Gateway strategy must be either 'single' or 'multiple'"
  }
}

variable "environment" {
  description = "Environment name for tagging"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Additional tags for all resources"
  type        = map(string)
  default     = {}
} 