variable "m_name" {
  description = "Base name used by the Route Table."
  type = string
}

variable "m_name_suffix" {
  description = "Suffix for the route table name."
  type = string
  default = null
}

variable "m_vpc_id" {
  description = "The VPC ID where to create the route table."
  type = string
}

variable "m_subnets_ids" {
  description = "List of subnet IDs to attatch to this route table."
  type = list(string)
  default = []
}

# TODO: Enable propagated routes from VGWs.
/* variable "m_propagated_vgws" {
  description = "value"
  type = list(string)
  default = []
} */

variable "m_routes" {
  description = "Map with routes to add into the route table."
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

variable "m_tags" {
  description = "Map with tags names and values."
  type = map(string)
  default = {}
}