
variable "vpc_tenancy" {
  description = "Tenancy of the VPC"
  type        = string
}

variable "cidr_block_vpc" {
  description = "CIDR block for the VPC"
  type        = string
}

# Availability Zones
variable "availability_zone_1" {
  description = "First availability zone"
  type        = string
}

variable "availability_zone_2" {
  description = "Second availability zone"
  type        = string
}

variable "availability_zone_3" {
  description = "Third availability zone"
  type        = string
}

# Public Subnets
variable "cidr_block_public1" {
  description = "CIDR block for the first public subnet"
  type        = string
}


variable "cidr_block_public2" {
  description = "CIDR block for the second public subnet"
  type        = string
}


# Private Subnets
variable "cidr_block_private1" {
  description = "CIDR block for the first private subnet"
  type        = string
}



variable "cidr_block_private2" {
  description = "CIDR block for the second private subnet"
  type        = string
}




# Route Tables (public and private)
variable "public_route_table_cidrblock" {
  description = "CIDR block for the public route table"
  type        = string
}

variable "public_route_table_Name" {
  description = "Name of the public route table"
  type        = string
}

variable "private_route_table_Name" {
  description = "Name of the private route table"
  type        = string
}

variable "private_route_table_cidrblock" {
  description = "CIDR block for the private route table"
  type        = string
}

variable "eip_name" {
  description = "Name of the Elastic IP"
  type        = string
}


# Security Group Tags
variable "frontend_sg_name" {
  description = "Name tag for the frontend security group"
  type        = string
}


variable "ssh_port" {
  description = "Port for SSH connection"
  type        = number
}
# EC2 Instance variables for frontend
variable "frontend_ami_id" {
  description = "AMI ID for Frontend EC2 instance"
}

variable "frontend_instance_type" {
  description = "Instance type for Frontend EC2 instance"
}

variable "frontend_subnet_id" {
  description = "Subnet ID for Frontend EC2 instance"
}

variable "frontend_key_name" {
  description = "Key name for Frontend EC2 instance"
}

variable "frontend_security_group_id" {
  description = "Security group ID for Frontend EC2 instance"
}

# EC2 Instance variables for backend
variable "backend_ami_id" {
  description = "AMI ID for Backend EC2 instance"
}

variable "backend_instance_type" {
  description = "Instance type for Backend EC2 instance"
}

variable "backend_subnet_id" {
  description = "Subnet ID for Backend EC2 instance"
}

variable "backend_key_name" {
  description = "Key name for Backend EC2 instance"
}

variable "backend_security_group_id" {
  description = "Security group ID for Backend EC2 instance"
}

# EC2 Instance variables for database
variable "database_ami_id" {
  description = "AMI ID for Database EC2 instance"
}

variable "database_instance_type" {
  description = "Instance type for Database EC2 instance"
}

variable "database_subnet_id" {
  description = "Subnet ID for Database EC2 instance"
}

variable "database_key_name" {
  description = "Key name for Database EC2 instance"
}

variable "database_security_group_id" {
  description = "Security group ID for Database EC2 instance"
}
