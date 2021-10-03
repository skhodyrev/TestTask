resource "aws_instance" "back_nginx" {
  count = var.back_count

  ami                         = "ami-05f7491af5eef733a" //Ubuntu Server 20.04 LTS (HVM), SSD Volume Type, Free tier eligible, Frankfurt
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.nginx.key_name
  subnet_id                   = aws_subnet.private.id
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id]
  associate_public_ip_address = true

  tags = {
    Name    = "nginx-${count.index + 1}"
    type    = "app"
    project = "test-task"
  }
}

resource "aws_instance" "bastion" {  
  ami                         = "ami-05f7491af5eef733a" //Ubuntu Server 20.04 LTS (HVM), SSD Volume Type, Free tier eligible, Frankfurt
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.bastion.key_name
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id]
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true

  tags = {
    Name    = "bastion"
    type    = "security"
    project = "test-task"
  }
}

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

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, var.subnet_cidr_newbits, 1)
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, var.subnet_cidr_newbits, 2)
  map_public_ip_on_launch = true

  tags = {
    Name = "private-subnet"
  }
}
