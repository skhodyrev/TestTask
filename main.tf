// This data will find the most recent image
data "aws_ami" "main" {
  most_recent = true

  filter {
    name   = "name"
    values = ["${var.ami_name}"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["${var.ami_owner_id}"]
}
resource "aws_instance" "back_nginx" {
  count = var.back_count

  ami                         = data.aws_ami.main.image_id
  instance_type               = var.ec2_instance_type
  key_name                    = aws_key_pair.nginx.key_name
  subnet_id                   = aws_subnet.privates[count.index % length(data.aws_availability_zones.available.names)].id // Sequentially places Instance into separate AZ networks
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id, aws_security_group.allow_http.id, aws_security_group.allow_ping.id]
  associate_public_ip_address = false

  tags = {
    Name    = format("nginx-%02d", count.index + 1)
    type    = "app"
    project = "test-task"
  }
}

resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.main.image_id
  instance_type               = var.ec2_instance_type
  key_name                    = aws_key_pair.bastion.key_name
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id, aws_security_group.allow_ping.id]
  subnet_id                   = aws_subnet.publics[0].id
  associate_public_ip_address = true

  tags = {
    Name    = "bastion-01"
    type    = "security"
    project = "test-task"
  }
}

### The Ansible inventory file
resource "local_file" "AnsibleInventory" {
  content = templatefile("inventory.tmpl",
    {
      bastion-name    = aws_instance.bastion.tags["Name"]
      bastion-ip      = aws_instance.bastion.public_ip,
      bastion-id      = aws_instance.bastion.id,
      nginx-name      = aws_instance.back_nginx[*].tags["Name"],
      nginx-ip        = aws_instance.back_nginx[*].private_ip,
      nginx-id        = aws_instance.back_nginx[*].id,
      username        = var.username_ami,
      ssh_nginx_key   = var.path_to_nginx_private_key,
      ssh_bastion_key = var.path_to_bastion_private_key
    }
  )
  filename = "inventory.ini"

  depends_on = [aws_lb.back_nginx, aws_lb_listener.back_nginx, aws_instance.bastion]
}

resource "null_resource" "run_ansible" {
  triggers = {
    always_run = "${timestamp()}"
  }

  depends_on = [local_file.AnsibleInventory]

  provisioner "local-exec" {
    command = "ansible-playbook nginx-install.yml"
  }
}
