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

output "vpc" {
  value = module.vpc
}

output "public_subnets" {
  value = module.public_subnets[*].subnet_object.id
}

output "public_route_table" {
  value = module.public_route_table.route_table
}