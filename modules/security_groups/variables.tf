variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "frontend_sg_name" {
  description = "Name tag for the frontend security group"
  type        = string
}

variable "backend_sg_name" {
  description = "Name tag for the backend security group"
  type        = string
}

variable "database_sg_name" {
  description = "Name tag for the database security group"
  type        = string
}
