variable "vpc_id" {
  
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

