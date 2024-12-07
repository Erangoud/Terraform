resource "aws_eip" "eipT" {
    vpc = true

    tags = {
      Name = var.eip_name
    }
}

resource "aws_nat_gateway" "NAT" {
  allocation_id = aws_eip.eipT.id
  subnet_id     = var.subnet_id
  tags = {
    Name = local.nat_gateway_name
  }
}
locals {
   nat_gateway_name = "${terraform.workspace}-nat-gateway"
}