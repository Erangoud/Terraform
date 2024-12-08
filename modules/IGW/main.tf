resource "aws_internet_gateway" "IgwT" {
  vpc_id = var.vpc_id

  tags = {
    Name = local.igw_name
  }
}

locals {
   igw_name= "${terraform.workspace}-igw"
}