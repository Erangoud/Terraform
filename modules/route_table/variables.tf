
variable "vpc_id" {}
variable "internet_gateway_id" {}
variable "nat_gateway_id" {}

variable "public_route_table_name" {
  default = "publicRT"
}
variable "private_route_table_name" {
  default = "privateRT"
}

variable "public_subnet_1_id" {}
variable "public_subnet_2_id" {}
variable "private_subnet_1_id" {}
variable "private_subnet_2_id" {}