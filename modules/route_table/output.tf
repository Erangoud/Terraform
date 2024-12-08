output "public_route_table_id" {
  value = aws_route_table.publicRT.id
}

output "private_route_table_id" {
  value = aws_route_table.privateRT.id
}
