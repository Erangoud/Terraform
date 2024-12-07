
resource "aws_subnet" "publicT1" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_block_public1
  availability_zone = var.availability_zone_1

  tags = {
    Name = local.public_subnet_name1
  }
}

resource "aws_subnet" "publicT2" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_block_public2
  availability_zone = var.availability_zone_2

  tags = {
    Name = local.public_subnet_name2
  }
}

resource "aws_subnet" "privateT3" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_block_private1
  availability_zone = var.availability_zone_2

  
  tags = {
    Name = local.private_subnet_name1
  }
}

resource "aws_subnet" "privateT4" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_block_private2
  availability_zone = var.availability_zone_3


  tags = {
    Name = local.private_subnet_name2
  }
}

locals {
   public_subnet_name1 = "${terraform.workspace}-public-subnet-1"
  public_subnet_name2 = "${terraform.workspace}-public-subnet-2"
  private_subnet_name1 = "${terraform.workspace}-private-subnet-1"
  private_subnet_name2 = "${terraform.workspace}-private-subnet-2"
}