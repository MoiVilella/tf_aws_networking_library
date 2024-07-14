module "vpc" {
  source = "../../resources/vpc"
  providers = {
    aws = aws
  }
  m_name      = var.m_name
  m_vpc_cidr  = var.m_cidr_block
  m_tags      = var.m_tags
}

module "igw" {
  source = "../../resources/internetGateway"
  m_name    = var.m_name
  m_vpc_id  = module.vpc.vpc_object.id
  m_tags    = var.m_tags
}

module "public_subnets" {
  source = "../../resources/subnet"
  providers = {
    aws = aws
  }
  for_each = local.az_map
    m_name        = var.m_name
    m_vpc_id      = module.vpc.vpc_object.id
    m_subnet_type = "public"
    m_subnet_az   = each.key
    m_cidr_block  = each.value.public_subnet
    m_tags        = var.m_tags
}

module "private_subnets" {
  source = "../../resources/subnet"
  providers = {
    aws = aws
  }
  for_each = local.az_map
    m_name        = var.m_name
    m_vpc_id      = module.vpc.vpc_object.id
    m_subnet_type = "private"
    m_subnet_az   = each.key
    m_cidr_block  = each.value.private_subnet
    m_tags        = var.m_tags
}

module "nat_gateways" {
  source = "../../resources/natGateway"
  count = length(module.public_subnets)
    m_name = var.m_name
    m_name_suffix = module.public_subnets[count.index].subnet_object.tags.SubnetAZ
    m_subnet_id = module.public_subnets[count.index].subnet_object.id
  
  depends_on = [module.igw]
}

module "public_route_table" {
  source = "../../resources/routeTable"
  m_name        = var.m_name
  m_name_suffix = "public"
  m_vpc_id      = module.vpc.vpc_object.id
  m_routes      = merge(
    var.m_global_routes,
    var.m_public_routes,
    {
      internet_route = {
        cidr_block = "0.0.0.0/0", 
        gateway_id = module.igw.igw_object.id
      }
    }, 
  )
  m_subnets_ids = module.public_subnets[*].subnet_object.id
  m_tags        = var.m_tags
}

module "private_route_tables" {
  source = "../../resources/routeTable"
  count = length(module.private_subnets)
    m_name        = var.m_name
    m_name_suffix = "private-${module.private_subnets[count.index].subnet_object.tags.SubnetAZ}"
    m_vpc_id      = module.vpc.vpc_object.id
    m_routes      = merge(
      var.m_global_routes,
      var.m_public_routes,
      {
        internet_route = {
          cidr_block = "0.0.0.0/0",
          nat_gateway_id = module.nat_gateways[count.index].nat_gateway.id
        }
      }
    )
    m_subnets_ids = [module.private_subnets[count.index].subnet_object.id]
    m_tags        = var.m_tags
}

module "public_network_acl" {
  source = "../../resources/networkACL"
  m_name        = var.m_name
  m_name_suffix = "public"
  m_vpc_id      = module.vpc.vpc_object.id
  m_subnets_ids = module.public_subnets[*].subnet_object.id
  m_ingress_rules = merge(
    var.m_global_ingress,
    var.m_public_ingress,
    {
      "100" = {
        action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "0.0.0.0/0"
      }
    }
  )
  m_egress_rules = merge(
    var.m_global_egress,
    var.m_public_egress,
    {
      "100" = {
        action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "0.0.0.0/0"
      }
    }
  )
  m_tags        = var.m_tags
}

module "private_network_acl" {
  source = "../../resources/networkACL"
  m_name        = var.m_name
  m_name_suffix = "private"
  m_vpc_id      = module.vpc.vpc_object.id
  m_subnets_ids = module.private_subnets[*].subnet_object.id
  m_ingress_rules = merge(
    var.m_global_ingress,
    var.m_private_ingress,
    {
      "100" = {
        action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "0.0.0.0/0"
      }
    }
  )
  m_egress_rules = merge(
    var.m_global_egress,
    var.m_private_egress,
    {
      "100" = {
        action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "0.0.0.0/0"
      }
    }
  )
  m_tags        = var.m_tags
}
