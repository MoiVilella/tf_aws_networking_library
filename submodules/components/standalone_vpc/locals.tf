locals {
  # AZ locals
  region_availability_zones = data.aws_availability_zones.available.names
  az_abbreviation           = [for zone in local.region_availability_zones:
    join("",
      [
        join("", 
          [
            for part in split("-", zone):
              substr(part, 0, 1)
          ]
        ),
        substr(zone, -1, 1)
      ]
    )
  ]

  # Subnetting locals
  cidr_mask       = split("/", var.m_cidr_block)[1]
  newbits_mask    = var.m_subneting_mask - local.cidr_mask
  subnet_count    = pow(2, local.newbits_mask)
  subnets         = [for i in range(local.subnet_count) : cidrsubnet(var.m_cidr_block, local.newbits_mask, i)]
  public_subnets  = slice(local.subnets, 0, length(local.region_availability_zones))
  private_subnets = slice(local.subnets, length(local.region_availability_zones), length(local.region_availability_zones) * 2)

  # AZ subnet map
  az_map = zipmap(
    local.region_availability_zones,
    [for idx in range(length(local.region_availability_zones)) : {
      public_subnet   = local.public_subnets[idx]
      private_subnet  = local.private_subnets[idx]
      az_abbreviation = local.az_abbreviation[idx]
    }]
  )
}
