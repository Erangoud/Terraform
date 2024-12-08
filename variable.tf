variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

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

variable "subnet_name_public1" {
  description = "Name of the first public subnet"
  type        = string
}

variable "cidr_block_public2" {
  description = "CIDR block for the second public subnet"
  type        = string
}

variable "subnet_name_public2" {
  description = "Name of the second public subnet"
  type        = string
}

# Private Subnets
variable "cidr_block_private1" {
  description = "CIDR block for the first private subnet"
  type        = string
}

variable "subnet_name_private1" {
  description = "Name of the first private subnet"
  type        = string
}

variable "cidr_block_private2" {
  description = "CIDR block for the second private subnet"
  type        = string
}

variable "subnet_name_private2" {
  description = "Name of the second private subnet"
  type        = string
}

variable "igw_name" {
  description = "Name of the Internet Gateway"
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

variable "ngw_name" {
  description = "Name of the NAT Gateway"
  type        = string
}

# Frontend Instance Variables
variable "frontend_instance_name" {
  description = "Name of the frontend EC2 instance"
  type        = string
}

variable "ami_id_f" {
  description = "AMI ID for the frontend instance"
  type        = string
}

variable "instance_type_f" {
  description = "Instance type for the frontend EC2 instance"
  type        = string
}

variable "key_name_f" {
  description = "Key name for SSH access to the frontend instance"
  type        = string
}

# Frontend Security Groups -----------------------------

# Ingress Variables
variable "protocol_tcp" {
  description = "Protocol for TCP connections"
  type        = string
}

variable "frontend_http_port" {
  description = "HTTP port for frontend"
  type        = number
}

variable "frontend_ssh_port" {
  description = "SSH port for frontend"
  type        = number
}

variable "frontend_custom_port" {
  description = "Custom port for frontend (e.g., 8000)"
  type        = number
}

variable "frontend_ingress_cidr" {
  description = "Allowed CIDR blocks for ingress traffic"
  type        = list(string)
}

variable "frontend_egress_cidr" {
  description = "Allowed CIDR blocks for egress traffic"
  type        = list(string)
}

# Security Group Tags
variable "frontend_sg_name" {
  description = "Name tag for the frontend security group"
  type        = string
}

# SSH Configuration for Frontend
variable "ssh_user" {
  description = "Username for SSH connection"
  type        = string
}

# variable "ssh_private_key_path" {
#   description = "Path to the private key file for SSH"
#   type        = string
# }

variable "ssh_port" {
  description = "Port for SSH connection"
  type        = number
}

variable "ssh_timeout" {
  description = "Timeout for SSH connection"
  type        = string
}

# Instance variables for Backend
variable "backend_instance_name" {
  description = "Name for the backend EC2 instance"
}

variable "ami_id_b" {
  description = "AMI ID for the backend EC2 instance"
}

variable "instance_type_b" {
  description = "Instance type for the backend EC2 instance"
}

variable "key_name_b" {
  description = "Key pair name for the backend EC2 instance"
}

# Backend Security Groups
variable "ingress_cidr" {
  description = "CIDR block for ingress rules"
  type        = string
}

variable "backend_security_group_name" {
  description = "Name for the backend security group"
  type        = string
}

variable "ssh_port_backend" {
  description = "Port for SSH access to the backend EC2 instance"
  type        = number
}

variable "backend_port" {
  description = "Port for the backend service (e.g., 8000)"
  type        = number
}

variable "database_port" {
  description = "Port for database connection (e.g., 5432)"
  type        = number
}

# # SSH connection for Backend
# variable "private_key_path_backend" {
#   description = "Path to the private key for the backend EC2 instance"
#   type        = string
# }

# variable "private_key_path_frontend" {
#   description = "Path to the private key for the frontend EC2 instance"
#   type        = string
# }

variable "timeout" {
  description = "Timeout duration for SSH connection"
  type        = string
}



# Database Security Groups
variable "database_security_group_name" {
  description = "Name for the database security group"
  type        = string
}

# Database EC2 Variables
variable "ami_id_database" {
  description = "AMI ID for the database instance"
  type        = string
}

variable "instance_type_database" {
  description = "Instance type for the database EC2"
  type        = string
}

variable "key_name_database" {
  description = "Key name for the database EC2 instance"
  type        = string
}

variable "database_name_tag" {
  description = "Name tag for the database instance"
  type        = string
}

# # Database PostgreSQL Setup Command
# variable "database_postgresql_update_command" {
#   description = "PostgreSQL setup commands for the database EC2 instance"
#   type        = list(string)
# }

# Database Connection Variables
variable "bastion_user" {
  description = "User for SSH connection to the bastion host"
  type        = string
}

# variable "bastion_private_key_path" {
#   description = "Path to the private key file for the bastion host"
#   type        = string
# }

# variable "private_key_path_database" {
#   description = "Path to the private key file for the database EC2 instance"
#   type        = string
# }

# Backend Target Groups
variable "lb_tg_backend_name" {
  description = "Name for the backend load balancer target group"
  type        = string
}

variable "backend_target_group_port" {
  description = "Port for the backend target group"
  type        = number
}

variable "backend_target_group_protocol" {
  description = "Protocol for the backend target group"
  type        = string
}

# Health Checks
variable "health_check_path" {
  description = "Path for the health check"
  type        = string
}

variable "health_check_interval" {
  description = "Interval between health checks (in seconds)"
  type        = number
}

variable "health_check_timeout" {
  description = "Timeout for health check response (in seconds)"
  type        = number
}

variable "health_check_healthy_threshold" {
  description = "Number of successful health checks for the target to be considered healthy"
  type        = number
}

variable "health_check_unhealthy_threshold" {
  description = "Number of failed health checks for the target to be considered unhealthy"
  type        = number
}

# Backend Load Balancer
variable "backend_lb_name" {
  description = "The name of the Backend Load Balancer"
  type        = string
}

variable "internal_lb" {
  description = "Whether the Load Balancer is internal (true) or external (false)"
  type        = bool
}

variable "load_balancer_type" {
  description = "Type of the load balancer"
  type        = string
}

variable "target_group_port" {
  description = "Port for the target group"
  type        = number
}

# Frontend Target Group
variable "lb_tg_frontend_name" {
  description = "The name of the frontend target group"
  type        = string
}

# Frontend Load Balancer
variable "frontend_lb_name" {
  description = "The name of the frontend load balancer"
  type        = string
}

variable "frontend_lb_internal" {
  description = "Whether the frontend load balancer is internal (true) or external (false)"
  type        = bool
}

variable "frontend_lb_type" {
  description = "The type of the frontend load balancer"
  type        = string
}

# Backend EC2 Launch Template and Auto Scaling Group
variable "backend_ami_name" {
  description = "AMI name for backend auto scaling"
  type        = string
}

variable "backend_LT_name" {
  description = "Backend launch template name"
  type        = string
}

variable "backend_IT_LT" {
  description = "Instance type for backend launch template"
  type        = string
}

# Auto Scaling Group Variables
variable "backend_asg_name" {
  description = "The name of the backend Auto Scaling group"
  type        = string
}

variable "backend_ags_tag_name" {
  description = "Tag name for backend auto scaling group"
  type        = string
}


variable "backend_asg_policy_name" {
  description = "Auto Scaling group policy name"
  type        = string
}

variable "backend_asg_policy_type" {
  description = "Auto Scaling group policy type"
  type        = string
}


#ssh---
variable "listener_type" {
  description = "Listener type for the load balancer"
  type        = string
}

#-------------------------------------------------------
# Frontend Variables
variable "frontend_ami_name" {
  description = "AMI name for frontend auto scaling"
  type        = string
}

variable "frontend_LT_name" {
  description = "Frontend launch template name"
  type        = string
}

variable "frontend_IT_LT" {
  description = "Instance type for frontend launch template"
  type        = string
}

variable "frontend_asg_name" {
  description = "The name of the frontend Auto Scaling group"
  type        = string
}

variable "desired_capacity" {
  description = "Desired number of instances in the Auto Scaling group"
  type        = number
}

variable "max_size" {
  description = "Maximum number of instances in the Auto Scaling group"
  type        = number
}

variable "min_size" {
  description = "Minimum number of instances in the Auto Scaling group"
  type        = number
}

variable "latest_version" {
  description = "The latest version of the launch template"
  type        = string
}

variable "frontend_asg_tag_name" {
  description = "Tag name for frontend Auto Scaling group"
  type        = string
}

variable "health_check_type" {
  description = "The health check type for the Auto Scaling group"
  type        = string
}

variable "health_check_grace_period" {
  description = "The grace period for health checks"
  type        = number
}

variable "frontend_asg_policy_name" {
  description = "Auto Scaling group policy name"
  type        = string
}

variable "frontend_asg_policy_type" {
  description = "Auto Scaling group policy type"
  type        = string
}

variable "asg_metric_type" {
  description = "Metric type for the Auto Scaling group"
  type        = string
}

variable "asg_metric_value" {
  description = "Metric value for the Auto Scaling group"
  type        = number
}
