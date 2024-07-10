module "vpc" {
  source = "../../resources/vpc"
  providers = {
    aws = aws
  }
  m_vpc_cidr = var.m_cidr_block
  m_tags = var.m_tags
}

module "public_subnets" {
  source = "../../resources/subnet"
  providers = {
    aws = aws
  }
  count = length(local.public_subnets)
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
    m_vpc_id        = module.vpc.vpc_object.id
    m_subnet_az     = local.region_availability_zones[count.index]
    m_cidr_block    = local.private_subnets[count.index]
    m_tags          = var.m_tags
}