/* output "public_connection_string" {
  description = "Copy/Paste/Enter - You are in the matrix"
  value       = "ssh -i ${module.ssh-key.key_name}.pem ec2-user@${module.ec2.public_ip}"
}*/

output "bastion_ip" {
  description = "bastion_ip"
  value       = aws_instance.bastion.public_ip
}

output "nginx_ip" {
  description = "bastion_ip"
  value       = [for s in aws_instance.back_nginx: format("%s \n\tPublic IP: %s \n\tPrivate IP: %s", s.tags["Name"], s.public_ip, s.private_ip)]
}
