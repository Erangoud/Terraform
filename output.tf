output "aws_vpc_id" {
    value = aws_vpc.vpcT.id
}

output "aws_subnet_publicT1_id" {
  value = aws_subnet.publicT1.id
}

output "aws_subnet_publicT2_id" {
  value = aws_subnet.publicT2.id
}

output "aws_subnet_privateT3_id" {
  value = aws_subnet.privateT3.id
}

output "aws_subnet_privateT4_id" {
  value = aws_subnet.privateT4.id
}

output "aws_eip_id" {
    value = aws_eip.eipT.id
}

output "aws_nat_gateway_id" {
    value = aws_nat_gateway.NAT.id
}

output "aws_route_table_prv_id" {
    value = aws_route_table.privateRT.id
}

output "aws_route_table_pub_id" {
  value = aws_route_table.publicRT.id
}

output "aws_security_group_bid" {
    value = aws_security_group.backend-sg-T.id
  
}

output "aws_security_group_fid" {
  value = aws_security_group.frontend-sg-T.id
}

output "aws_instance_bid" {
  value = aws_instance.backend-ec2.id
}
output "aws_instance_fid" {
  value = aws_instance.frontend-ec2.id
}


output "aws_security_group_did" {
 value = aws_security_group.database-sg-T.id
}

output "aws_instance_did" {
  value = aws_instance.database-ec2.id
}

# Backend Load Balancer Outputs
output "backend_lb_arn" {
  value = aws_lb.Backend_lb.arn
}

output "backend_lb_id" {
  value = aws_lb.Backend_lb.id
}

output "backend_lb_dns_name" {
  value = aws_lb.Backend_lb.dns_name
}

# Backend EC2 Instance Outputs
output "backend_instance_public_ip" {
  value = aws_instance.backend-ec2.public_ip
}

output "backend_instance_private_ip" {
  value = aws_instance.backend-ec2.private_ip
}

output "backend_instance_id" {
  value = aws_instance.backend-ec2.id
}

# Database EC2 Instance Outputs
output "database_instance_public_ip" {
  value = aws_instance.database-ec2.public_ip
}

output "database_instance_private_ip" {
  value = aws_instance.database-ec2.private_ip
}

output "database_instance_id" {
  value = aws_instance.database-ec2.id
}

# Frontend EC2 Instance Outputs
output "frontend_instance_public_ip" {
  value = aws_instance.frontend-ec2.public_ip
}

output "frontend_instance_private_ip" {
  value = aws_instance.frontend-ec2.private_ip
}

output "frontend_instance_id" {
  value = aws_instance.frontend-ec2.id
}

# Frontend Load Balancer Outputs
output "frontend_lb_arn" {
  value = aws_lb.Frontend_lb.arn
}

output "frontend_lb_id" {
  value = aws_lb.Frontend_lb.id
}

output "frontend_lb_dns_name" {
  value = aws_lb.Frontend_lb.dns_name
}

# Backend Security Group Output
output "backend_sg_id" {
  value = aws_security_group.backend-sg-T.id
}
