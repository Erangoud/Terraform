resource "aws_vpc" "vpcT" {
  cidr_block       = var.cidr_block_vpc
  instance_tenancy = var.vpc_tenancy

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "publicT1" {
  vpc_id     = aws_vpc.vpcT.id
  cidr_block = var.cidr_block_public1
  availability_zone = var.availability_zone_1

  tags = {
    Name = var.subnet_name_public1
  }
}

resource "aws_subnet" "publicT2" {
  vpc_id     = aws_vpc.vpcT.id
  cidr_block = var.cidr_block_public2
  availability_zone = var.availability_zone_2

  tags = {
    Name = var.subnet_name_public2
  }
}

resource "aws_subnet" "privateT3" {
  vpc_id     = aws_vpc.vpcT.id
  cidr_block = var.cidr_block_private1
  availability_zone = var.availability_zone_2

  
  tags = {
    Name = var.subnet_name_private1
  }
}

resource "aws_subnet" "privateT4" {
  vpc_id     = aws_vpc.vpcT.id
  cidr_block = var.cidr_block_private2
  availability_zone = var.availability_zone_3


  tags = {
    Name = var.subnet_name_private2
  }
}

resource "aws_internet_gateway" "IgwT" {
  vpc_id = aws_vpc.vpcT.id

  tags = {
    Name = var.igw_name
  }
}
 
resource "aws_eip" "eipT" {
    domain = "vpc"
    tags = {
      Name = var.eip_name
    }
}

resource "aws_nat_gateway" "NAT" {
  allocation_id = aws_eip.eipT.id
  subnet_id     = aws_subnet.publicT1.id

  tags = {
    Name = var.ngw_name
  }
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.IgwT]
}


resource "aws_route_table" "publicRT" {
  vpc_id = aws_vpc.vpcT.id

  route {
    cidr_block = var.public_route_table_cidrblock
    gateway_id = aws_internet_gateway.IgwT.id
  }
  tags = {
    Name = var.public_route_table_Name
  }
}

resource "aws_route_table" "privateRT" {
  vpc_id = aws_vpc.vpcT.id

  route {
    cidr_block = var.private_route_table_cidrblock
    gateway_id = aws_nat_gateway.NAT.id
  }
  tags = {
    Name = var.private_route_table_Name
  }
}

#subnet association
resource "aws_route_table_association" "private_as_1" {
  subnet_id = aws_subnet.privateT3.id

  route_table_id = aws_route_table.privateRT.id
}
#subnet association
resource "aws_route_table_association" "private_as_2" {
  subnet_id = aws_subnet.privateT4.id

  route_table_id = aws_route_table.privateRT.id
}
#subnet association
resource "aws_route_table_association" "public_as_1" {
  subnet_id      = aws_subnet.publicT1.id

  route_table_id = aws_route_table.publicRT.id
}
#subnet association
resource "aws_route_table_association" "public_as_2" {
  subnet_id      = aws_subnet.publicT2.id

  route_table_id = aws_route_table.publicRT.id
}

# Create Security Group for Frontend EC2 Instance
resource "aws_security_group" "frontend-sg-T" {
  vpc_id = aws_vpc.vpcT.id
  ingress {
    from_port   = var.frontend_http_port
    to_port     = var.frontend_http_port
    protocol    = var.protocol_tcp
    cidr_blocks = var.frontend_ingress_cidr
  }

  ingress {
    from_port   = var.frontend_ssh_port
    to_port     = var.frontend_ssh_port
    protocol    = var.protocol_tcp
    cidr_blocks = var.frontend_ingress_cidr
  }

  ingress {
    from_port   = var.frontend_custom_port
    to_port     = var.frontend_custom_port
    protocol    = var.protocol_tcp
    cidr_blocks = var.frontend_ingress_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.frontend_egress_cidr
  }

  tags = {
    Name = var.frontend_sg_name
  }
}

# Create Frontend EC2 Instance
resource "aws_instance" "frontend-ec2" {
  ami                     = var.ami_id_f
  instance_type            = var.instance_type_f
  subnet_id               = aws_subnet.publicT1.id
  key_name                = var.key_name_f
  associate_public_ip_address = true
  security_groups         = [aws_security_group.frontend-sg-T.id]
  tags = {
    Name = var.frontend_instance_name
  }

  provisioner "remote-exec" {
    inline = [
  # Update server_name with the frontend DNS
  "sudo sed -i 's|server_name .*|server_name ${aws_lb.Frontend_lb.dns_name};|' /etc/nginx/sites-available/fundoo.conf",

  # Update proxy_pass with the backend DNS
  "sudo sed -i 's|proxy_pass .*|proxy_pass http://${aws_lb.Backend_lb.dns_name}:8000;|' /etc/nginx/sites-available/fundoo.conf",

  # Reload or restart Nginx to apply the changes
  "sudo systemctl daemon-reload",
  "sudo systemctl reload nginx"
]


   connection {
    type        = "ssh"
    user        = var.ssh_user
    private_key = file(var.ssh_private_key_path)
    host        = self.public_ip
    port        = var.ssh_port
    timeout     = var.ssh_timeout
  }
  }
  depends_on = [aws_lb.Frontend_lb, aws_lb.Backend_lb]
}

# Create Security Group for Backend EC2 Instance
resource "aws_security_group" "backend-sg-T" {
  vpc_id = aws_vpc.vpcT.id
   ingress {
    from_port   = var.ssh_port_backend
    to_port     = var.ssh_port_backend
    protocol    = var.protocol_tcp
    cidr_blocks = [var.ingress_cidr]
  }

  ingress {
    from_port   = var.backend_port
    to_port     = var.backend_port
    protocol    = var.protocol_tcp
    cidr_blocks = [var.ingress_cidr]
  }

  ingress {
    from_port   = var.database_port
    to_port     = var.database_port
    protocol    = var.protocol_tcp
    cidr_blocks = [var.ingress_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.ingress_cidr]
  }

  tags = {
    Name = var.backend_security_group_name
  }
}



# Create Security Group for Database EC2 Instance
resource "aws_security_group" "database-sg-T" {
  vpc_id = aws_vpc.vpcT.id 
ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = var.protocol_tcp
    cidr_blocks = [var.ingress_cidr]
  }

  ingress {
    from_port   = var.database_port
    to_port     = var.database_port
    protocol    = var.protocol_tcp
    cidr_blocks = [var.ingress_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.ingress_cidr]
  }

  tags = {
    Name = var.database_security_group_name
  }
}
# Create Database EC2 Instance
resource "aws_instance" "database-ec2" {
  ami                   = var.ami_id_database
  instance_type         = var.instance_type_database
  subnet_id             = aws_subnet.privateT4.id
  key_name              = var.key_name_database
  security_groups       = [aws_security_group.database-sg-T.id]
  tags = {
    Name = var.database_name_tag
  }
}

# Null Resource for Database Setup
resource "null_resource" "database_setup" {
  triggers = {
    instance_id = aws_instance.database-ec2.id
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Running setup for Database EC2'",
      "sudo apt update -y",
      "sudo apt install -y postgresql postgresql-contrib",
      "sudo systemctl enable postgresql",
      "sudo systemctl start postgresql",
      "sudo -u postgres psql -c \"CREATE USER eran WITH PASSWORD '123456789';\"",
      "sudo -u postgres psql -c \"CREATE DATABASE fundoodb OWNER eran;\"",
      "sudo sed -i \"s/#listen_addresses = 'localhost'/listen_addresses = '*'/g\" /etc/postgresql/16/main/postgresql.conf",
      "sudo bash -c 'echo \"host all all 0.0.0.0/0 md5\" >> /etc/postgresql/*/main/pg_hba.conf'",
      "sudo systemctl restart postgresql"
    ]

    connection {
      type                = "ssh"
      user                = var.bastion_user
      private_key         = file(var.private_key_path_database)
      host                = aws_instance.database-ec2.private_ip
      port                = 22
      timeout             = "20m"  # Increased timeout for long-running scripts
      bastion_host        = aws_instance.frontend-ec2.public_ip
      bastion_user        = var.bastion_user
      bastion_private_key = file(var.bastion_private_key_path)
    }
  }

  depends_on = [aws_instance.database-ec2]
}

# Create Backend EC2 Instance
resource "aws_instance" "backend-ec2" {
  ami                     = var.ami_id_b
  instance_type           = var.instance_type_b
  key_name                = var.key_name_b
  subnet_id               = aws_subnet.privateT3.id
  security_groups         = [aws_security_group.backend-sg-T.id]
  tags = {
    Name = var.backend_instance_name
  }
}

# Null Resource for Backend Setup
resource "null_resource" "backend_setup" {
  triggers = {
    instance_id = aws_instance.backend-ec2.id
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Updating DB_HOST in env file...'",
      "sudo sed -i 's/DB_HOST=.*/DB_HOST=${aws_instance.database-ec2.private_ip}/' /etc/fundoo/env.conf",
      "sudo systemctl daemon-reload",
      "echo 'DB_HOST update completed.'",
      "echo 'Activating virtual environment and running migrations...'",
      "sudo su eran bash -c 'cd /Aws_test && source myenv/bin/activate && echo \"Virtual environment activated.\" && cd /Aws_test/fundoo_notes && python3 manage.py makemigrations && python3 manage.py migrate'",
      "echo 'Migrations completed.'",
      "sudo systemctl restart fundoo.service"
    ]

    connection {
      type                = "ssh"
      user                = var.ssh_user
      private_key         = file(var.private_key_path_backend)
      host                = aws_instance.backend-ec2.private_ip
      bastion_host        = aws_instance.frontend-ec2.public_ip
      bastion_private_key = file(var.private_key_path_frontend)
      port                = 22
      timeout             = "10m"
    }
  }

  depends_on = [
    aws_instance.backend-ec2,
    null_resource.database_setup  # Ensure database provisioning completes first
  ]
}


# Target group and load balancer for Backend

resource "aws_lb_target_group" "TG-backend" {
  name     = var.lb_tg_backend_name
  port     = var.backend_target_group_port
  protocol = var.backend_target_group_protocol
  vpc_id   = aws_vpc.vpcT.id

#Health check 
health_check {
  protocol = var.backend_target_group_protocol
   path                = var.health_check_path
    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold

}
}
resource "aws_lb_target_group_attachment" "backend_targets" {
  target_group_arn = aws_lb_target_group.TG-backend.arn
  target_id = aws_instance.backend-ec2.id
  port = var.backend_target_group_port
}

resource "aws_lb" "Backend_lb" {
  name               = var.backend_lb_name
  internal           = var.internal_lb
  load_balancer_type = var.load_balancer_type
  subnets = [aws_subnet.privateT3.id,aws_subnet.privateT4.id]
  security_groups = [aws_security_group.backend-sg-T.id]

}

# Listener for backend
resource "aws_lb_listener" "http_listener1" {
  load_balancer_arn = aws_lb.Backend_lb.arn
  port              = var.backend_target_group_port
  protocol          = var.backend_target_group_protocol

  default_action {
    type             = var.listener_type
    target_group_arn = aws_lb_target_group.TG-backend.arn
  }
}

# Listener for backend
resource "aws_lb_listener" "http_listener2" {
  load_balancer_arn = aws_lb.Backend_lb.arn
  port              = var.target_group_port
  protocol          = var.backend_target_group_protocol

  default_action {
    type             = var.listener_type
    target_group_arn = aws_lb_target_group.TG-backend.arn
  }
}





## load balancer and target group for frontend 

resource "aws_lb_target_group" "TG-frontend" {
  name     = var.lb_tg_frontend_name
  port     = var.target_group_port
  protocol = var.backend_target_group_protocol
  vpc_id   = aws_vpc.vpcT.id

#Health check 
health_check {
 protocol = var.backend_target_group_protocol  #protocol is same
   path                = var.health_check_path
    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
}

}
resource "aws_lb_target_group_attachment" "Frontend_targets" {
  target_group_arn = aws_lb_target_group.TG-frontend.arn
  target_id = aws_instance.frontend-ec2.id
  port = var.target_group_port
}

resource "aws_lb" "Frontend_lb" {
   name               = var.frontend_lb_name      
  internal           = var.frontend_lb_internal    
  load_balancer_type = var.frontend_lb_type 
  subnets = [aws_subnet.publicT1.id,aws_subnet.publicT2.id]
  security_groups = [aws_security_group.frontend-sg-T.id]
}

# Listener for frontend
resource "aws_lb_listener" "http_listener3" {
  load_balancer_arn = aws_lb.Frontend_lb.arn
  port              = var.target_group_port
  protocol          = var.backend_target_group_protocol

  default_action {
    type             = var.listener_type
    target_group_arn = aws_lb_target_group.TG-frontend.arn
  }
}

#-----------------------------------------------------#

#backendami-T
resource "aws_ami_from_instance" "backend_ami" {
  name = var.backend_ami_name
  source_instance_id  = aws_instance.backend-ec2.id  

  depends_on = [null_resource.backend_setup]
}

#Backend Launch template
resource "aws_launch_template" "back_LT" {
  name          = var.backend_LT_name
  image_id      = aws_ami_from_instance.backend_ami.id
  instance_type = var.backend_IT_LT
  key_name      = var.key_name_b

  network_interfaces {
  security_groups = [aws_security_group.backend-sg-T.id]
 }
depends_on = [aws_ami_from_instance.backend_ami]
}


#Backend auto scaling
resource "aws_autoscaling_group" "backend_asg" {
 name                      = var.backend_asg_name           
  desired_capacity           = var.desired_capacity          
  max_size                  = var.max_size 
  min_size                  = var.min_size

  launch_template {
    id      = aws_launch_template.back_LT.id
    version = var.latest_version
  }

  vpc_zone_identifier  = [aws_subnet.privateT3.id,aws_subnet.privateT4.id]

  target_group_arns    = [aws_lb_target_group.TG-backend.arn]


 tag {
  key                 = "Name"
  value               = var.backend_ags_tag_name
  propagate_at_launch = true
}

health_check_type         = var.health_check_type
health_check_grace_period = var.health_check_grace_period

  lifecycle {
    create_before_destroy = true
  }
depends_on = [aws_launch_template.back_LT]
}



#Backend auto scaling policy 
resource "aws_autoscaling_policy" "backend_target_tracking_policy" {
  name                   = var.backend_asg_policy_name
  autoscaling_group_name   = aws_autoscaling_group.backend_asg.name
  policy_type            = var.backend_asg_policy_type

  target_tracking_configuration {
  predefined_metric_specification {
    predefined_metric_type = var.asg_metric_type
  }

  target_value = var.asg_metric_value
 }
 depends_on = [aws_autoscaling_group.backend_asg]
}

#Frontend ASG & AMI & launch template-------------------------------------- 

#ami-T-frontend 
resource "aws_ami_from_instance" "Frontend_ami" {
   name  = var.frontend_ami_name # Ensure unique name
  source_instance_id  = aws_instance.frontend-ec2.id  

 depends_on = [ aws_ami_from_instance.backend_ami,
               null_resource.backend_setup ]  
}


#Frontend Launch template
resource "aws_launch_template" "Front_LT" {
  name          = var.frontend_LT_name
  image_id      = aws_ami_from_instance.Frontend_ami.id
  instance_type = var.frontend_IT_LT
  key_name      = var.key_name_f

  network_interfaces {
  security_groups = [aws_security_group.frontend-sg-T.id]
 }
depends_on = [aws_ami_from_instance.Frontend_ami]
}


#Frontend auto scaling
resource "aws_autoscaling_group" "frontend_asg" {
 name = var.frontend_asg_name
 desired_capacity     = 2
  max_size             = 5
  min_size             = 1

  launch_template {
    id      = aws_launch_template.Front_LT.id  
    version = var.latest_version
  }

  vpc_zone_identifier  = [aws_subnet.publicT1.id,aws_subnet.publicT2.id]

  target_group_arns    = [aws_lb_target_group.TG-frontend.arn]


 tag {
  key                 = "Name"
  value               = var.frontend_asg_tag_name
  propagate_at_launch = true
}

health_check_type         = var.health_check_type
health_check_grace_period = var.health_check_grace_period

  lifecycle {
    create_before_destroy = true
  }
depends_on = [aws_launch_template.Front_LT]
}



#frontend auto scaling policy 
resource "aws_autoscaling_policy" "Frontend_target_tracking_policy" {
  name                   = var.frontend_asg_policy_name
  autoscaling_group_name   = aws_autoscaling_group.frontend_asg.name
  policy_type            = var.frontend_asg_policy_type

  target_tracking_configuration {
  predefined_metric_specification {
    predefined_metric_type = var.asg_metric_type
  }

  target_value = var.asg_metric_value   
 }
 depends_on = [aws_autoscaling_group.frontend_asg]
}
