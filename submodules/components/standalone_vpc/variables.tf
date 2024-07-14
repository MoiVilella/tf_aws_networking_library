variable "m_aws_region" {
  description = "AWS region for the us-east VPC"
  type = string
  default = "eu-west-1"
}

variable "m_name" {
  description = "Base name used for resources created by this module."
  type = string
}

variable "m_cidr_block" {
  description = "The IPv4 CIDR block for the VPC."
  type = string

  validation {
		condition = can(regex("^((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\\.){3}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\\/(3[0-2]|[1-2]?[0-9])$", var.m_cidr_block))
    error_message = "The CIDR block is not valid. Ensure the IP is correct and contains the mask"
	}
}

variable "m_subneting_mask" {
  description = "Mask for making subnetting from the CIDR block and use those subnetted blocks for creating the subnets"
  type = number

  validation {
    condition = pow(2, (var.m_subneting_mask - split("/", var.m_cidr_block)[1])) >= length(local.region_availability_zones) * 2
    error_message = "The subnetting result gived ${pow(2, (var.m_subneting_mask - split("/", var.m_cidr_block)[1]))} subnet availabe, but as there is ${length(local.region_availability_zones)} AZs, the module requires ${length(local.region_availability_zones) * 2} subnets. Increase the m_subneting_mask variable."
  }
}

variable "m_global_routes" {
  description = "Map with global routes to add into all route tables."
  type = map(object({
    cidr_block                = string
    gateway_id                = optional(string)
    nat_gateway_id            = optional(string)
    network_interface_id      = optional(string)
    transit_gateway_id        = optional(string)
    vpc_endpoint_id           = optional(string)
    vpc_peering_connection_id = optional(string)
  }))
  default = {}
}

variable "m_public_routes" {
  description = "Map with routes to add into public route tables."
  type = map(object({
    cidr_block                = string
    gateway_id                = optional(string)
    nat_gateway_id            = optional(string)
    network_interface_id      = optional(string)
    transit_gateway_id        = optional(string)
    vpc_endpoint_id           = optional(string)
    vpc_peering_connection_id = optional(string)
  }))
  default = {}
}

variable "m_private_routes" {
  description = "Map with routes to add into private route tables."
  type = map(object({
    cidr_block                = string
    gateway_id                = optional(string)
    nat_gateway_id            = optional(string)
    network_interface_id      = optional(string)
    transit_gateway_id        = optional(string)
    vpc_endpoint_id           = optional(string)
    vpc_peering_connection_id = optional(string)
  }))
  default = {}
}

variable "m_global_egress" {
  description = "Map with global routes to add into all route tables."
  type = map(object({
    action      = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = optional(string)
    icmp_type   = optional(number)
    icmp_code   = optional(number)
  }))
  default = {}
}

variable "m_public_egress" {
  description = "Map with routes to add into public route tables."
  type = map(object({
    action      = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = optional(string)
    icmp_type   = optional(number)
    icmp_code   = optional(number)
  }))
  default = {}
}

variable "m_private_egress" {
  description = "Map with routes to add into private route tables."
  type = map(object({
    action      = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = optional(string)
    icmp_type   = optional(number)
    icmp_code   = optional(number)
  }))
  default = {}
}

variable "m_global_ingress" {
  description = "Map with global routes to add into all route tables."
  type = map(object({
    action      = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = optional(string)
    icmp_type   = optional(number)
    icmp_code   = optional(number)
  }))
  default = {}
}

variable "m_public_ingress" {
  description = "Map with routes to add into public route tables."
  type = map(object({
    action      = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = optional(string)
    icmp_type   = optional(number)
    icmp_code   = optional(number)
  }))
  default = {}
}

variable "m_private_ingress" {
  description = "Map with routes to add into private route tables."
  type = map(object({
    action      = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = optional(string)
    icmp_type   = optional(number)
    icmp_code   = optional(number)
  }))
  default = {}
}

variable "m_tags" {
  description = "Map with tags names and values."
  type = map(string)
  default = {}
}