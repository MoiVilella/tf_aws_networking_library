locals {
  region_availability_zones = data.aws_availability_zones.available.names

  # Subnetting locals
  cidr_mask       = split("/", var.m_cidr_block)[1]
  newbits_mask    = var.m_subneting_mask - local.cidr_mask
  subnet_count    = pow(2, local.newbits_mask)
  subnets         = [for i in range(local.subnet_count) : cidrsubnet(var.m_cidr_block, local.newbits_mask, i)]
  public_subnets  = slice(local.subnets, 0, length(local.region_availability_zones))
  private_subnets = slice(local.subnets, length(local.region_availability_zones), length(local.region_availability_zones) * 2)
}
