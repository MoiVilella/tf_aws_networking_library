variable "m_vpc_id" {
  description = "value"
  type = string
}

variable "m_subnets_ids" {
  description = "value"
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
  description = "value"
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