terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

module "naming" {
  source = "../../logics/naming"
  m_resource_prefix = "subnet"
  m_resource_name = local.full_name
  m_tags = var.m_tags
}

resource "aws_subnet" "subnet" {
  vpc_id                                         = var.m_vpc_id
  availability_zone                              = var.m_subnet_az
  cidr_block                                     = var.m_cidr_block
  map_public_ip_on_launch                        = var.m_public_subnet
  tags                                           = module.naming.tags
}