module "naming" {
  source = "../../logics/naming"
  m_resource_prefix = "nat"
  m_resource_name   = var.m_name
  m_resource_suffix = var.m_name_suffix
  m_tags            = var.m_tags
}

resource "aws_eip" "nat_elastic_ip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_elastic_ip.id
  subnet_id     = var.m_subnet_id

  tags = module.naming.tags
}
