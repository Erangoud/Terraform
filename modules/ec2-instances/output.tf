output "frontend_instance_id" {
  value = aws_instance.frontend_ec2.id
}

output "backend_instance_id" {
  value = aws_instance.backend_ec2.id
}

output "database_instance_id" {
  value = aws_instance.database_ec2.id
}
