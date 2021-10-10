output "bastion_ip" {
  description = "bastion_ip"
  value       = aws_instance.bastion.public_ip
}

output "nginx_ips" {
  description = "bastion_ip"
  value       = [for s in aws_instance.back_nginx : format("%s Private IP: %s", s.tags["Name"], s.private_ip)]
}

output "nginx_lb_dns" {
  value       = aws_lb.back_nginx.dns_name
  description = "The DNS name of Nginx LB"
}

output "public_connection_string_bastion" {
  description = "Copy/Paste/Enter - You are in the bastion"
  value = [format("ssh -o StrictHostKeyChecking=no %s@%s -i %s",
    var.username_ami,
    aws_instance.bastion.public_ip,
    var.path_to_bastion_private_key)]
}

output "public_connection_string_nginxes" {
  description = "Copy/Paste/Enter - You are in the nginx"
  value = [for s in aws_instance.back_nginx :
    format("ssh -o StrictHostKeyChecking=no -o ProxyCommand='ssh -W %%h:%%p -q %s@%s -i %s' %s@%s -i %s",
      var.username_ami,
      aws_instance.bastion.public_ip,
      var.path_to_bastion_private_key,
      var.username_ami,
      s.private_ip,
      var.path_to_nginx_private_key)]
}

output "test_lb_request" {
  value       = format("for i in {1..10}; do curl -s %s | grep h1; done", aws_lb.back_nginx.dns_name)
  description = "Copy/Paste/Enter to test if LB is work correctly"
}
