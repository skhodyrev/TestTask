/* output "public_connection_string" {
  description = "Copy/Paste/Enter - You are in the matrix"
  value       = "ssh -o ProxyCommand='ssh -i bastion.pem -W %h:%p ubuntu@${aws_instance.bastion.public_ip}' -i nginx.pem ubuntu@${aws_instance.back_nginx[*].private_ip}"
  value = [for s in aws_instance.back_nginx: format("ssh -o ProxyCommand='ssh -i bastion.pem -W %h:%p ubuntu@%s", s.private_ip)]
} */

output "bastion_ip" {
  description = "bastion_ip"
  value       = aws_instance.bastion.public_ip
}

output "nginx_ips" {
  description = "bastion_ip"
  value       = [for s in aws_instance.back_nginx: format("%s Private IP: %s", s.tags["Name"], s.private_ip)]
}

output "nginx_lb_dns" {
  value       = aws_lb.back_nginx.dns_name
  description = "The DNS name of Nginx LB"
}