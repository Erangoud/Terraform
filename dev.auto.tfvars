vpc_name            = "vpcT"
vpc_tenancy         = "default"
cidr_block_vpc      = "10.0.0.0/24"

availability_zone_1 = "ap-south-1a"
availability_zone_2 = "ap-south-1b"
availability_zone_3 = "ap-south-1c"

cidr_block_public1  = "10.0.0.0/26"
subnet_name_public1 = "publicT1"

cidr_block_public2  = "10.0.0.64/26"
subnet_name_public2 = "publicT2"

cidr_block_private1 = "10.0.0.128/26"
subnet_name_private1 = "privateT3"

cidr_block_private2 = "10.0.0.192/26"
subnet_name_private2 = "privateT4"

igw_name              = "IgwT"

# Route Tables (public and private)
public_route_table_cidrblock = "0.0.0.0/0"
public_route_table_Name     = "publicRT"
private_route_table_Name    = "privateRT"
private_route_table_cidrblock = "0.0.0.0/0"

eip_name             = "eipT"
ngw_name             = "ngwT"

# Frontend Instance Variables
frontend_instance_name = "frontend-ec2"
ami_id_f              = "ami-0d614c8ef6a7ad604"
instance_type_f       = "t2.micro"
key_name_f            = "fundoo-frontend-key"

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

# SSH Configuration for Frontend
ssh_user             = "ubuntu"
# ssh_private_key_path = "./fundoo-backend-key.pem"
ssh_port             = 22
ssh_timeout          = "10m"

# Instance variables for Backend
backend_instance_name = "backend-ec2"
ami_id_b              = "ami-05d8605a8c4737417"
instance_type_b       = "t2.micro"
key_name_b            = "fundoo-backend-key"

# Backend Security Groups
ingress_cidr          = "0.0.0.0/0"
backend_security_group_name = "backend-sg-T"
ssh_port_backend      = 22
backend_port          = 8000
database_port         = 5432

# SSH connection for Backend
# private_key_path_backend = "./fundoo-backend-key.pem"
# private_key_path_frontend = "./fundoo-frontend-key.pem"
timeout                 = "10m"

# Database Security Groups
database_security_group_name = "database-sg-T"

# Database EC2 Variables
ami_id_database             = "ami-0dee22c13ea7a9a67"
instance_type_database      = "t3.micro"
key_name_database           = "fundoo-database-key"
database_name_tag           = "database-instance"


# Database Connection Variables
bastion_user               = "ubuntu"
# bastion_private_key_path   = "./fundoo-frontend-key.pem"
# private_key_path_database  = "./fundoo-database-key.pem"

# Backend Target Groups
lb_tg_backend_name        = "tf-back-lb-tg"
backend_target_group_port = 8000
backend_target_group_protocol = "HTTP"

# Health Checks
health_check_path               = "/home/"
health_check_interval           = 30
health_check_timeout            = 5
health_check_healthy_threshold  = 3
health_check_unhealthy_threshold = 2

# Backend Load Balancer
backend_lb_name  = "Lb-backend"
internal_lb      = true
load_balancer_type = "application"
target_group_port = 80

# Frontend Target Group
lb_tg_frontend_name = "tf-front-lb-tg"

# Frontend Load Balancer
frontend_lb_name    = "Lb-Frontend"
frontend_lb_internal = false
frontend_lb_type    = "application"

# Backend EC2 Launch Template and Auto Scaling Group
backend_ami_name = "Backami-T"
backend_LT_name  = "backend-T"
backend_IT_LT    = "t3.micro"

# Auto Scaling Group Variables
backend_asg_name    = "backend-asg"
desired_capacity     = 1
max_size             = 3
min_size             = 1
latest_version       = "$Latest"
backend_ags_tag_name = "back-asg-T"
health_check_type    = "ELB"
health_check_grace_period = 300
backend_asg_policy_name = "backend-target-tracking-policy"
backend_asg_policy_type = "TargetTrackingScaling"
asg_metric_type      = "ASGAverageCPUUtilization"
asg_metric_value     = 70
listener_type        = "forward"

#asg-frontend
frontend_ami_name          = "Frontend-ami-T"
frontend_LT_name           = "Frontend-T"
frontend_IT_LT             = "t2.micro"
frontend_asg_name          = "frontend-asg"
frontend_asg_tag_name      = "front-asg-T"
frontend_asg_policy_name   = "frontend-target-tracking-policy"
frontend_asg_policy_type   = "TargetTrackingScaling"