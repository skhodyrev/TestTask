resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_instance" "back_nginx" {
  count = var.back_count

  ami                         = "ami-05f7491af5eef733a" //Ubuntu Server 20.04 LTS (HVM), SSD Volume Type, Free tier eligible, Frankfurt
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.nginx.key_name
  subnet_id                   = aws_subnet.privates[count.index % length(data.aws_availability_zones.available.names)].id
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id, aws_security_group.allow_http.id, aws_security_group.allow_ping.id]
  associate_public_ip_address = false

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
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id, aws_security_group.allow_ping.id]
  subnet_id                   = aws_subnet.publics[0].id
  associate_public_ip_address = true

  provisioner "file" {
    source      = local_file.nginx_private_key.filename
    destination = "/home/ubuntu/.ssh/id_rsa"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${local_file.bastion_private_key.filename}")
      host        = self.public_ip
    }
  }

  //chmod key 400 on EC2 instance
  provisioner "remote-exec" {
    inline = ["chmod 400 /home/ubuntu/.ssh/id_rsa"]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${local_file.bastion_private_key.filename}")
      host        = self.public_ip
    }
  }

  tags = {
    Name    = "bastion-01"
    type    = "security"
    project = "test-task"
  }
}