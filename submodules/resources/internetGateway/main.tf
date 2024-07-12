module "naming" {
  source = "../../logics/naming"
  m_resource_prefix = "igw"
  m_resource_name = var.m_name
  m_tags = var.m_tags
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = var.m_vpc_id

  tags = module.naming.tags
}