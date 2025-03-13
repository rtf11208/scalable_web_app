
# local variables for the public and private subnets 
locals {
  public_subnet = {
    public_subnet_1 = { cidr = "10.0.1.0/24", az_index = 0 }
    public_subnet_2 = { cidr = "10.0.2.0/24", az_index = 1 }
  }

  private_subnet = {
    private_subnet_1 = { cidr = "10.0.3.0/24", az_index = 0 }
    private_subnet_2 = { cidr = "10.0.4.0/24", az_index = 1 }
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
  for_each                = local.public_subnet
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[each.value.az_index]
  map_public_ip_on_launch = true

  tags = {
    Name = each.key
  }
}


#creates the private subnets
resource "aws_subnet" "private_subnet" {
  for_each          = local.private_subnet
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = data.aws_availability_zones.available_zones.names[each.value.az_index]

  tags = {
    Name = each.key
  }
}



# creates an internet gateway
resource "aws_internet_gateway" "ronnie_internet_gateway" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "ronnie_internet_gateway"
  }
}

# creates a route that directs internet bound traffic to the internet gateway
resource "aws_route_table" "name" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ronnie_internet_gateway.id
  }
  tags = {
    Name = "ronnie_route_table"
  }
}

# associates the route table with the public subnets
resource "aws_route_table_association" "public_subnet_association" {
  for_each       = aws_subnet.public_subnet
  route_table_id = aws_route_table.name.id
  subnet_id      = each.value.id
}
