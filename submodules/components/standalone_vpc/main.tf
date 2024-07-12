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
  count = length(local.public_subnets)
    m_name          = var.m_name
    m_vpc_id        = module.vpc.vpc_object.id
    m_subnet_az     = local.region_availability_zones[count.index]
    m_cidr_block    = local.public_subnets[count.index]
    m_public_subnet = true
    m_tags          = var.m_tags
}

module "private_subnets" {
  source = "../../resources/subnet"
  providers = {
    aws = aws
  }
  count = length(local.private_subnets)
    m_name          = var.m_name
    m_vpc_id        = module.vpc.vpc_object.id
    m_subnet_az     = local.region_availability_zones[count.index]
    m_cidr_block    = local.private_subnets[count.index]
    m_tags          = var.m_tags
}

# TODO: Create NAT Gateways for private subnets

module "public_route_table" {
  source = "../../resources/routeTable"
  m_name        = var.m_name
  m_name_suffix = "public"
  m_vpc_id      = module.vpc.vpc_object.id
  m_routes      = merge(
    {
      internet_route = {
        cidr_block = "0.0.0.0/0", 
        gateway_id = module.igw.igw_object.id
      }
    }, 
    var.m_global_routes, 
    var.m_public_routes
  )
  m_subnets_ids = module.public_subnets[*].subnet_object.id
  m_tags        = var.m_tags
}

module "private_route_tables" {
  source = "../../resources/routeTable"
  count = length(module.private_subnets)
    m_name        = var.m_name
    m_name_suffix = "private-0${count.index + 1}"
    m_vpc_id      = module.vpc.vpc_object.id
    m_routes      = merge(
      # TODO: Add internet route through NAT
      var.m_global_routes, 
      var.m_public_routes
    )
    m_subnets_ids = [module.private_subnets[count.index].subnet_object.id]
    m_tags        = var.m_tags
}
