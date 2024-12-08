resource "aws_vpc" "vpcT" {
  cidr_block       = var.cidr_block_vpc
  instance_tenancy = var.vpc_tenancy

  tags = {
    Name = local.vpc_name
  }
}

locals {
  vpc_name            = "${terraform.workspace}-vpc"
}