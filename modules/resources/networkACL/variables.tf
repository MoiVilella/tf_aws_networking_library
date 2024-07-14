variable "m_name" {
  description = "Base name used by the Network ACL."
  type = string
}

variable "m_name_suffix" {
  description = "Suffix for the the Network ACL name."
  type = string
  default = null
}

variable "m_vpc_id" {
  description = "The VPC ID where to create the Network ACL."
  type = string
}

variable "m_subnets_ids" {
  description = "List of subnet IDs to attatch to this Network ACL."
  type = list(string)
  default = []
}

variable "m_ingress_rules" {
  description = "Map with ingress rules to add into the Network ACL."
  type = map(object({
    action      = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = optional(string)
    icmp_type   = optional(number, 0)
    icmp_code   = optional(number, 0)
  }))
  default = {}
}

variable "m_egress_rules" {
  description = "Map with egress rules to add into the Network ACL."
  type = map(object({
    action      = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = optional(string)
    icmp_type   = optional(number, 0)
    icmp_code   = optional(number, 0)
  }))
  default = {}
}

variable "m_tags" {
  description = "Map with tags names and values."
  type = map(string)
  default = {}
}
