

resource "aws_route_table" "publicRT" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }
  tags = {
    Name = "publicRT"
  }
}

resource "aws_route_table" "privateRT" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
   nat_gateway_id = var.nat_gateway_id
  }
  tags = {
    Name = "privateRt"
  }
}

#subnet association
resource "aws_route_table_association" "private_as_1" {
  subnet_id = var.public_subnet_1_id

  route_table_id = aws_route_table.privateRT.id
}
#subnet association
resource "aws_route_table_association" "private_as_2" {
  subnet_id = var.private_subnet_1_id

  route_table_id = aws_route_table.privateRT.id
}
#subnet association
resource "aws_route_table_association" "public_as_1" {
  subnet_id      =var.public_subnet_2_id

  route_table_id = aws_route_table.publicRT.id
}
#subnet association
resource "aws_route_table_association" "public_as_2" {
  subnet_id      =var.private_subnet_2_id
  route_table_id = aws_route_table.publicRT.id
}
