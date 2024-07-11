resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = var.m_vpc_id

  tags = var.m_tags
}