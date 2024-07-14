variable "m_name" {
  description = "Base name used by the Subnet"
  type = string
}

variable "m_subnet_type" {
  description = "Type of subnet."
  type = string
  validation {
	condition = can(index(["public", "private"], var.m_subnet_type))
	error_message = "The subnet type must be one of: private, public"
  }
}

variable "m_vpc_id" {
  description = "The VPC ID where to create the subnet."
	type = string
}

variable "m_subnet_az" {
	description = "AZ for the subnet."
	type = string
}

variable "m_cidr_block" {
	description = "The IPv4 CIDR block for the subnet."
	type = string
	validation {
		condition = can(regex("^((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\\.){3}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\\/(3[0-2]|[1-2]?[0-9])$", var.m_cidr_block))
    error_message = "The CIDR block is not valid. Ensure the IP is correct and contains the mask"
	}
}

variable "m_public_subnet" {
	description = "A boolean flag to enable/disable that new instances launched into the subnet should be assigned a public IP address."
	type = bool
	default = false
}

variable "m_tags" {
  description = "Map with tags names and values."
  type = map(string)
  default = {}
}
