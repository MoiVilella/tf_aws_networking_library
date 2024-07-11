locals {
  region_availability_zones = data.aws_availability_zones.available.names

  # Subnetting locals
  # cidr_without_mask         = split("/", var.m_cidr_block)[0]
  cidr_mask       = split("/", var.m_cidr_block)[1]
  subnet_count    = pow(2, (var.m_subneting_mask - local.cidr_mask))
  subnets         = [for i in range(local.subnet_count) : cidrsubnet(var.m_cidr_block, 3, i)]
  public_subnets  = slice(local.subnets, 0, 3)
  private_subnets = slice(local.subnets, 3, 6)

  # TODO: Global tagging
}