
# local variables for the public and private subnets 
locals {
  public_subnet = {
    public_subnet_1 = {cidr = "10.0.1.0/24", az_index = 0}
    public_subnet_2 = {cidr = "10.0.2.0/24", az_index = 1}
  }

  private_subnet = {
    private_subnet_1 = {cidr = "10.0.3.0/24", az_index = 0}
    private_subnet_2 = {cidr = "10.0.4.0/24", az_index = 1}
  }

}

#creates the vpc resource
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "ronnie_vpc"
  }
}

#creates the public subnets
resource "aws_subnet" "public_subnet" {
  for_each = local.public_subnet
  vpc_id = aws_vpc.main.id
  cidr_block = each.value.cidr
  availability_zone = data.aws_availability_zones.available_zones.names[each.value.az_index]
  map_public_ip_on_launch = true

  tags = {
    Name = each.key
  }
}

#creates the private subnets
resource "aws_subnet" "private_subnet" {
  for_each = local.private_subnet
  vpc_id = aws_vpc.main.id
  cidr_block = each.value.cidr
  availability_zone = data.aws_availability_zones.available_zones.names[each.value.az_index]

  tags = {
    Name = each.key
  }
}



