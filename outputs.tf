/* output "public_connection_string" {
  description = "Copy/Paste/Enter - You are in the matrix"
  value       = "ssh -i ${module.ssh-key.key_name}.pem ec2-user@${module.ec2.public_ip}"
}

output "private_connection_string" {
  description = "Copy/Paste/Enter - You are in the private ec2 instance"
  value       = "ssh -i ${module.ssh-key.key_name}.pem ec2-user@${module.ec2.private_ip}"
} */

output "bastion_ip" {
  description = "bastion_ip"
  value       = aws_instance.bastion.public_ip
}

output "nginx_ip" {
  description = "bastion_ip"
  value       = aws_instance.back_nginx[*].public_ip
}

