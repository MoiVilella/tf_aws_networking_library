locals {
  az_abbreviation   = join("", [join("", [for part in split("-", var.m_subnet_az) : substr(part, 0, 1)]), substr(var.m_subnet_az, -1, 1)])
  subnet_archetype  = var.m_public_subnet == false ? "private" : "public"
  full_name         = join("-", [var.m_name, local.az_abbreviation, local.subnet_archetype])
  tags              = merge(var.m_tags, {SubnetType = local.subnet_archetype, SubnetAZ = local.az_abbreviation})
}