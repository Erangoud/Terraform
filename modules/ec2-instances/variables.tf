# Frontend EC2 variables
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

# Backend EC2 variables
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

# Database EC2 variables
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
