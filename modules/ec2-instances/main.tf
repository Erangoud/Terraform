resource "aws_instance" "frontend_ec2" {
  ami                         = var.frontend_ami_id
  instance_type               = var.frontend_instance_type
  subnet_id                   = var.frontend_subnet_id
  key_name                    = var.frontend_key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.frontend_security_group_id]
  tags = {
    Name = local.frontend_instance_name
  }
}

resource "aws_instance" "backend_ec2" {
  ami               = var.backend_ami_id
  instance_type     = var.backend_instance_type
  subnet_id         = var.backend_subnet_id
  key_name          = var.backend_key_name
  vpc_security_group_ids = [var.backend_security_group_id]
  tags = {
    Name = local.backend_instance_name
  }
}

resource "aws_instance" "database_ec2" {
  ami               = var.database_ami_id
  instance_type     = var.database_instance_type
  subnet_id         = var.database_subnet_id
  key_name          = var.database_key_name
  vpc_security_group_ids = [var.database_security_group_id]
  tags = {
    Name = local.database_instance_name
  }
}

locals {
  frontend_instance_name = "${terraform.workspace}-frontend-ec2"
  backend_instance_name  = "${terraform.workspace}-backend-ec2"
  database_instance_name = "${terraform.workspace}-database-ec2"
}
