# nombre: rt-test-public | rt-test-private-ew1a

module "naming" {
  source = "../../logics/naming"
  m_resource_prefix = "rt"
  m_resource_name   = var.m_name
  m_resource_suffix = var.m_name_suffix
  m_tags            = var.m_tags
}

resource "aws_route_table" "route_table" {
  vpc_id  = var.m_vpc_id
  # propagating_vgws = var.m_propagated_vgws

  tags    = module.naming.tags

  dynamic "route" {
    for_each = var.m_routes

    content {
      cidr_block                = route.value.cidr_block
      gateway_id                = try(route.value.gateway_id, null)
      nat_gateway_id            = try(route.value.nat_gateway_id, null)
      network_interface_id      = try(route.value.network_interface_id, null)
      transit_gateway_id        = try(route.value.transit_gateway_id, null)
      vpc_endpoint_id           = try(route.value.vpc_endpoint_id, null)
      vpc_peering_connection_id = try(route.value.vpc_peering_connection_id, null)
    }
  }
}

resource "aws_route_table_association" "route_table_association" {
  count = length(var.m_subnets_ids)
    subnet_id      = var.m_subnets_ids[count.index]
    route_table_id = aws_route_table.route_table.id
}
