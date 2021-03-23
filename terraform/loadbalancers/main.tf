
resource "aws_lb" "loadbalancer" {
  name = "app-load-balancer"
  internal = false
  load_balancer_type = "application"
  security_groups = var.ec2-sg
  subnets = var.subnets
  tags = {
      Name = "App_LoadBalancer"
  }
}

resource "aws_lb_target_group" "lb_target" {
  name = "tg-load-balancer"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc-name
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.loadbalancer.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.lb_target.arn
  }
}