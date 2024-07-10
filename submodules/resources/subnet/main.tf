terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "aws_subnet" "subnet" {
  availability_zone                              = var.m_subnet_az
  cidr_block                                     = var.m_cidr_block
  map_public_ip_on_launch                        = var.m_public_subnet
  tags                                           = var.m_tags
  vpc_id                                         = var.m_vpc_id
}