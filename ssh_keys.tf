### BASTION keys ###
data "tls_public_key" "bastion" {
  private_key_pem = "${chomp(file("${var.path_to_bastion_private_key}"))}"
}

resource "aws_key_pair" "bastion" {
  key_name   = "bastion"
  public_key = data.tls_public_key.bastion.public_key_openssh
}

### NGINX keys ###
data "tls_public_key" "nginx" {
  private_key_pem = "${chomp(file("${var.path_to_nginx_private_key}"))}" 
}


resource "aws_key_pair" "nginx" {
  key_name   = "nginx"
  public_key = data.tls_public_key.nginx.public_key_openssh
}
