resource "aws_instance" "back_nginx" {
  count = var.back_count

  ami                         = "ami-05f7491af5eef733a" //Ubuntu Server 20.04 LTS (HVM), SSD Volume Type, Free tier eligible, Frankfurt
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.nginx.key_name
  subnet_id                   = aws_subnet.private.id
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id, 
                                 aws_security_group.allow_http.id, 
                                 aws_security_group.allow_ping.id]
  associate_public_ip_address = true

  tags = {
    Name    = format("nginx-%02d", count.index + 1)
    type    = "app"
    project = "test-task"
  }
}

resource "aws_instance" "bastion" {
  ami                         = "ami-05f7491af5eef733a" //Ubuntu Server 20.04 LTS (HVM), SSD Volume Type, Free tier eligible, Frankfurt
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.bastion.key_name
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id, 
                                 aws_security_group.allow_ping.id]
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
