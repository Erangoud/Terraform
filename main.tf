module "vpc" {
  source = "./modules/vpc"
  cidr_block_vpc = var.cidr_block_vpc
  vpc_tenancy = var.vpc_tenancy 
}

module "subnets" {
  source               = "./modules/subnets"
  vpc_id               = module.vpc.vpc_id  
  cidr_block_public1   = var.cidr_block_public1
  cidr_block_public2   = var.cidr_block_public2
  cidr_block_private1  = var.cidr_block_private1
  cidr_block_private2  = var.cidr_block_private2
  availability_zone_1  = var.availability_zone_1
  availability_zone_2  = var.availability_zone_2
  availability_zone_3  = var.availability_zone_3
}

module "IGW" {
  source = "./modules/IGW"
  vpc_id = module.vpc.vpc_id
  
}

module "Nat" {
  source = "./modules/NAT"
  eip_name       = var.eip_name
  subnet_id      = module.subnets.aws_subnet_publicT1_id
  internet_gateway_id = module.IGW.internet_gateway_id
}

module "route_table" {
  source = "./modules/route_table"

  # Inputs
  vpc_id               = module.vpc.vpc_id
  internet_gateway_id  = module.IGW.internet_gateway_id
  nat_gateway_id = module.Nat.aws_nat_gateway_id

  public_subnet_1_id = module.subnets.aws_subnet_publicT1_id
  public_subnet_2_id = module.subnets.aws_subnet_publicT2_id
  private_subnet_1_id = module.subnets.aws_subnet_privateT3_id
  private_subnet_2_id = module.subnets.aws_subnet_privateT4_id
}

module "security_groups" {
  source            = "./modules/security_groups"
  vpc_id            = module.vpc.vpc_id
  frontend_sg_name  = var.frontend_sg_name
  backend_sg_name   = "backend-sg-T"
  database_sg_name  = "database-sg-T"
}


module "instances" {
  source = "./modules/ec2-instances"

  # Frontend instance
  frontend_ami_id            = var.frontend_ami_id
  frontend_instance_type     = var.frontend_instance_type
  frontend_subnet_id         = module.subnets.aws_subnet_publicT1_id
  frontend_key_name          = var.frontend_key_name
  frontend_security_group_id = module.security_groups.frontend_sg_id

  # Backend instance
  backend_ami_id             = var.backend_ami_id
  backend_instance_type      = var.backend_instance_type
  backend_subnet_id          = module.subnets.aws_subnet_privateT3_id
  backend_key_name           = var.backend_key_name
  backend_security_group_id  = module.security_groups.backend_sg_id

  # Database instance
  database_ami_id            = var.database_ami_id
  database_instance_type     = var.database_instance_type
  database_subnet_id         = module.subnets.aws_subnet_privateT4_id
  database_key_name          = var.database_key_name
  database_security_group_id = module.security_groups.database_sg_id
}
