# Set account-wide variables. These are automatically pulled in to configure the remote state bucket in the root.hcl configuration
locals {
  account_name   = "examples"
  aws_account_id = "062421853504" # TODO: replace me with your AWS account ID!
}