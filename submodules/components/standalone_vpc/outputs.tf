/* output "region" {
  value = module.vpc
} */

output "zones" {
  value = local.region_availability_zones
}

output "subnets_pool" {
  value = local.subnets
}

output "public_subnets_cidrs" {
  value = local.public_subnets
}

output "private_subnets_cidrs" {
  value = local.private_subnets
}

output "az_subnet_map" {
  value = local.az_map
}

output "vpc" {
  value = module.vpc
}

output "public_route_table" {
  value = module.public_route_table.route_table
}

output "nat_gateways" {
  value = module.nat_gateways[*].nat_gateway
}