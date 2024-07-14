variable "m_name" {
  description = "Base name used by the NAT Gateway."
  type = string
}

variable "m_name_suffix" {
  description = "Suffix for the Nat Gateway name."
  type = string
  default = null
}

variable "m_subnet_id" {
  description = "The Subnet ID where to create the subnet."
  type = string
}

variable "m_tags" {
  description = "Map with tags names and values."
  type = map(string)
  default = {}
}
