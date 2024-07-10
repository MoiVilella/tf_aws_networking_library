terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "aws_vpc" "main" {
  cidr_block            = var.m_vpc_cidr
  enable_dns_support    = var.m_dns_support
  enable_dns_hostnames  = var.m_dns_hostnames

  tags = var.m_tags
}
