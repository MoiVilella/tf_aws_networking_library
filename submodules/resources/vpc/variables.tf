variable "m_vpc_cidr" {
  description = "IP CIDR block used by the VPC."
  type = string
  validation {
    condition = can(regex("^((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\\.){3}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\\/(3[0-2]|[1-2]?[0-9])$", var.m_vpc_cidr))
    error_message = "The CIDR block is not valid. Ensure the IP is correct and contains the mask."
  }
}

variable "m_dns_support" {
  description = "A boolean flag to enable/disable DNS support in the VPC. The DNS resolution attribute determines whether DNS resolution through the Amazon DNS server is supported for the VPC."
  type = bool
  default = true
}

variable "m_dns_hostnames" {
  description = "A boolean flag to enable/disable DNS hostnames in the VPC. The DNS hostnames attribute determines whether instances launched in the VPC receive public DNS hostnames that correspond to their public IP addresses."
  type = bool
  default = false
}

variable "m_tags" {
  description = "Map with tags names and values."
  type = map(string)
}