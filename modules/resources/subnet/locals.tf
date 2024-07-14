locals {
  az_abbreviation   = join("", 
    [
      join("", 
        [
          for part in split("-", var.m_subnet_az):
            substr(part, 0, 1)
        ]
      ),
      substr(var.m_subnet_az, -1, 1)
    ]
  )
  full_name         = join("-",
    [
      var.m_name,
      local.az_abbreviation,
      var.m_subnet_type
    ]
  )
  tags              = merge(var.m_tags, {SubnetType = var.m_subnet_type, SubnetAZ = local.az_abbreviation})
}