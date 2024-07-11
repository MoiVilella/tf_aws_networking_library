variable "m_resource_prefix" {
  description = "Prefix used by Name tag to show the rource type."
  type = string
}

variable "m_resource_name" {
  description = "Name for the resource."
  type = string
}

variable "m_tags" {
  description = "Tags to merge with Name tag."
  type = map(string)
}
