locals {
  name = join("-", [var.m_resource_prefix, var.m_resource_name])
  tags = merge({Name = local.name}, var.m_tags)
}