include "root" {
  path = find_in_parent_folders("root.hcl")
}

# Configure the version of the module to use in this environment. This allows you to promote new versions one
# environment at a time (e.g., qa -> stage -> prod).
terraform {
  source = "git@github.com:MoiVilella/tf_aws_networking_library//modules/components/standalone_vpc?ref=v0.1.0"
}

# ---------------------------------------------------------------------------------------------------------------------
# Override parameters for this environment
# ---------------------------------------------------------------------------------------------------------------------

# For production, we want to specify bigger instance classes and cluster, so we specify override parameters here. These
# inputs get merged with the common inputs from the root and the envcommon terragrunt.hcl
inputs = {
  m_name            = "test"
  m_cidr_block      = "192.168.0.0/21"
  m_subneting_mask  = 24
}