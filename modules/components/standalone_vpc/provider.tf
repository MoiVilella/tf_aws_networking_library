provider "aws" {
  region = var.m_aws_region

  default_tags {
    tags = {
      Environment = "Laboratory"
      Project = "testLab"
    }
  }
}
