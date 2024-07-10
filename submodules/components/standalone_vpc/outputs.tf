/* output "region" {
  value = module.vpc
} */

output "zones" {
  value = local.region_availability_zones
}

output "subnets_pool" {
  value = local.subnets
}

output "public_subnets" {
  value = local.public_subnets
}

output "private_subnets" {
  value = local.private_subnets
}

output "vpc" {
  value = module.vpc
}