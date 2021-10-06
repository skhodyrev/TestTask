resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-vpc-igw"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  az_count = length(data.aws_availability_zones.available.names)
  az_names = data.aws_availability_zones.available.names[*]
}



resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "public"
  }
}

resource "aws_subnet" "publics" {
  count = local.az_count

  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, var.subnet_cidr_newbits, count.index)
  availability_zone       = local.az_names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${local.az_names[count.index]}"
  }
}

resource "aws_route_table_association" "publics" {
  count          = local.az_count
  subnet_id      = aws_subnet.publics[count.index].id
  route_table_id = aws_route_table.public.id
}



resource "aws_subnet" "privates" {
  count                   = local.az_count
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, var.subnet_cidr_newbits, local.az_count + count.index)
  availability_zone       = local.az_names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "private-subnet-${local.az_names[count.index]}"
  }
}

resource "aws_route_table_association" "privates" {
  count          = local.az_count
  subnet_id      = aws_subnet.privates[count.index].id
  route_table_id = aws_route_table.privates[count.index].id
}

resource "aws_route_table" "privates" {
  count = local.az_count

  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngws[count.index].id
  }

  tags = {
    Name = "private-rt-${local.az_names[count.index]}"
  }
}

resource "aws_eip" "nats" {
  count = local.az_count

  vpc = true
  tags = {
    Name = "aws-eip-${local.az_names[count.index]}"
  }
}

resource "aws_nat_gateway" "ngws" {
  count = local.az_count

  allocation_id = aws_eip.nats[count.index].id
  subnet_id     = aws_subnet.publics[count.index].id

  tags = {
    Name = "nat-gw-${local.az_names[count.index]}"
  }

  depends_on = [aws_internet_gateway.main]
}
