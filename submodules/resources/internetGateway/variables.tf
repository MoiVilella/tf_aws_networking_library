variable "m_name" {
  description = "Base name used by the Internet Gateway"
  type = string
}

variable "m_vpc_id" {
  description = "The ID of the VPC where to create the Internet Gateway."
  type = string
}

variable "m_tags" {
  description = "Map with tags names and values."
  type = map(string)
  default = {}
}