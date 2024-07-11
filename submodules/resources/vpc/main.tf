terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

module "naming" {
  source = "../../logics/naming"
  m_resource_prefix = "vpc"
  m_resource_name = var.m_name
  m_tags = var.m_tags
}

resource "aws_vpc" "main" {
  cidr_block            = var.m_vpc_cidr
  enable_dns_support    = var.m_dns_support
  enable_dns_hostnames  = var.m_dns_hostnames

  tags = module.naming.tags
}
