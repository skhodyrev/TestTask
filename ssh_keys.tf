### BASTION keys ###
resource "aws_key_pair" "bastion" {
  key_name   = "bastion"
  public_key = "${chomp(file("${var.path_to_bastion_public_key}"))}"
}

### NGINX keys ###
resource "aws_key_pair" "nginx" {
  key_name   = "nginx"
  public_key = "${chomp(file("${var.path_to_nginx_public_key}"))}"
}
