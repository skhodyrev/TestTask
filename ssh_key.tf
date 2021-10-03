### BASTION keys ###
resource "tls_private_key" "bastion" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "local_file" "bastion_private_key" {
  content         = tls_private_key.bastion.private_key_pem
  filename        = "bastion.pem"
  file_permission = "0600"
}

resource "aws_key_pair" "bastion" {
  key_name   = "bastion"
  public_key = tls_private_key.bastion.public_key_openssh
}

### NGINX keys, *.pem will be copied to the Bastion host ###
resource "tls_private_key" "nginx" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "local_file" "nginx_private_key" {
  content         = tls_private_key.nginx.private_key_pem
  filename        = "nginx.pem"
  file_permission = "0600"
}

resource "aws_key_pair" "nginx" {
  key_name   = "nginx"
  public_key = tls_private_key.nginx.public_key_openssh
}
