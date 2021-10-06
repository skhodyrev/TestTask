# Application Load Balancers
resource "aws_lb" "back_nginx" {
  name               = "back-nginx-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http.id]
  subnets            = aws_subnet.publics[*].id

  tags = {
    Name = "back-nginx-lb"
  }
}

# Target Group
resource "aws_lb_target_group" "back_nginx" {
  name     = "back-nginx-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  load_balancing_algorithm_type = "round_robin"

  health_check {
    interval            = 10
    path                = "/index.nginx-debian.html"
    port                = 80
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }

  target_type = "instance"

  tags = {
    Name = "back-nginx-lb-tg"
  }
}

# ALB Listeners
resource "aws_lb_listener" "back_nginx" {
  load_balancer_arn = aws_lb.back_nginx.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.back_nginx.arn
  }
}

# ALB Target Group Attachments
resource "aws_lb_target_group_attachment" "targets" {
  count            = var.back_count
  target_group_arn = aws_lb_target_group.back_nginx.arn
  target_id        = aws_instance.back_nginx[count.index].id
  port             = 80
}
