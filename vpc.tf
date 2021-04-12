resource "aws_vpc" "challenge" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_hostnames = "true"

  tags = {
    Name = "${local.project_name}-vpc"
  }
}