output "vpc_id" {
  value = module.vpc.vpc_id
}
output "aws_subnet_publicT1_id" {
  value = module.subnets.aws_subnet_publicT1_id
}

output "aws_subnet_publicT2_id" {
  value = module.subnets.aws_subnet_publicT2_id
}

output "aws_subnet_privateT3_id" {
  value = module.subnets.aws_subnet_privateT3_id
}

output "aws_subnet_privateT4_id" {
  value = module.subnets.aws_subnet_privateT4_id
}

output "natgw_id" {
  value = module.Nat.aws_nat_gateway_id
}

output "internet_gateway_id" {
  value = module.IGW.internet_gateway_id
}

output "public_route_table_id" {
  value = module.route_table.public_route_table_id
}

output "private_route_table_id" {
  value = module.route_table.private_route_table_id
}

output "frontend_sg_id" {
  value = module.security_groups.frontend_sg_id
}

output "backend_sg_id" {
  value = module.security_groups.backend_sg_id
}

output "database_sg_id" {
  value = module.security_groups.database_sg_id
}
output "frontend_instance_id" {
  value = module.instances.frontend_instance_id
}

output "backend_instance_id" {
  value = module.instances.backend_instance_id
}

output "database_instance_id" {
  value = module.instances.database_instance_id
}
