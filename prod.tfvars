
vpc_tenancy         = "default"
cidr_block_vpc      = "10.0.0.0/24"

availability_zone_1 = "ap-south-1a"
availability_zone_2 = "ap-south-1b"
availability_zone_3 = "ap-south-1c"
# Public Subnets
cidr_block_public1   = "10.0.0.0/26"
cidr_block_public2   = "10.0.0.64/26"

# Private Subnets

cidr_block_private1  = "10.0.0.128/26"
cidr_block_private2  = "10.0.0.192/26"



# Route Tables (public and private)
public_route_table_cidrblock = "0.0.0.0/0"
public_route_table_Name     = "publicRT"
private_route_table_Name    = "privateRT"
private_route_table_cidrblock = "0.0.0.0/0"

eip_name             = "eipT"

# Frontend Instance Variables

frontend_ami_id            = "ami-0d614c8ef6a7ad604"
frontend_instance_type = "t3.large"
frontend_key_name           = "fundoo-frontend-key"

# Frontend Security Groups -----------------------------

# Ingress Variables
protocol_tcp        = "tcp"
frontend_http_port  = 80
frontend_ssh_port   = 22
frontend_custom_port = 8000

frontend_ingress_cidr = ["0.0.0.0/0"]
frontend_egress_cidr  = ["0.0.0.0/0"]

# Security Group Tags
frontend_sg_name     = "frontend-sg-T"


# Instance variables for Backend
backend_instance_name = "backend-ec2"
backend_ami_id          = "ami-05d8605a8c4737417"
backend_instance_type     = "t3.large"
backend_key_name = "fundoo-backend-key"

# Backend Security Groups
ingress_cidr          = "0.0.0.0/0"
backend_security_group_name = "backend-sg-T"
ssh_port_backend      = 22
backend_port          = 8000
database_port         = 5432


# Database Security Groups
database_security_group_name = "database-sg-T"

# Database EC2 Variables
database_ami_id            = "ami-0dee22c13ea7a9a67"
database_instance_type      = "t3.large"
database_key_name    = "fundoo-database-key"
ssh_port = "22"