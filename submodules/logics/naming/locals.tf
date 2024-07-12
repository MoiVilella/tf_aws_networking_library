locals {
  name_with_suffix = var.m_resource_suffix != null ? join("-", [var.m_resource_name, var.m_resource_suffix]) : var.m_resource_name
  name = join("-", [var.m_resource_prefix, local.name_with_suffix])
  tags = merge({Name = local.name}, var.m_tags)
}