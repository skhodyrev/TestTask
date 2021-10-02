resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "local_file" "private_key" {
  content         = tls_private_key.ssh.private_key_pem
  filename        = "ssh_private.key"
  file_permission = "0600"
}

resource "local_file" "public_key" {
  content         = tls_private_key.ssh.public_key_openssh
  filename        = "ssh_public.key"
  file_permission = "0600"
}

resource "aws_key_pair" "automation" {
  key_name   = "auto"
  public_key = tls_private_key.ssh.public_key_openssh
}

resource "aws_instance" "back_nginx" {
  count         = var.back_count
  ami           = "ami-05f7491af5eef733a" //Ubuntu Server 20.04 LTS (HVM), SSD Volume Type, Free tier eligible, Frankfurt
  instance_type = "t2.micro"
  key_name = aws_key_pair.automation.key_name

  tags = {
    name    = "nginx-${count.index + 1}"
    type    = "app"
    project = "test-task"
  }
}

