module "naming" {
  source = "../../logics/naming"
  m_resource_prefix = "acl"
  m_resource_name   = var.m_name
  m_resource_suffix = var.m_name_suffix
  m_tags            = var.m_tags
}

resource "aws_network_acl" "network_acl" {
  vpc_id = var.m_vpc_id

  tags = module.naming.tags

  dynamic "egress" {
    for_each = var.m_egress_rules

    content {
      rule_no     = tonumber(egress.key)
      action      = egress.value.action
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_block  = try(egress.value.cidr_block, null)
      icmp_type   = try(egress.value.icmp_type, null)
      icmp_code   = try(egress.value.icmp_code, null)
    }
  }
  
  dynamic "ingress" {
    for_each = var.m_ingress_rules

    content {
      rule_no     = tonumber(ingress.key)
      action      = ingress.value.action
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_block  = try(ingress.value.cidr_block, null)
      icmp_type   = try(ingress.value.icmp_type, null)
      icmp_code   = try(ingress.value.icmp_code, null)
    }
  }
}

resource "aws_network_acl_association" "network_acl_association" {
  count = length(var.m_subnets_ids)
    subnet_id      = var.m_subnets_ids[count.index]
    network_acl_id = aws_network_acl.network_acl.id
}
