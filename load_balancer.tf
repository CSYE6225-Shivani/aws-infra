resource "aws_lb_target_group" "target_group_load_balancer" {
  depends_on  = [aws_vpc.aws_vpc, aws_db_instance.postgres_database]
  name        = var.lb_target_group_name
  port        = var.target_group_port
  protocol    = var.target_group_protocol
  vpc_id      = aws_vpc.aws_vpc.id
  target_type = var.target_type

  health_check {
    healthy_threshold   = var.target_group_healthy
    unhealthy_threshold = var.target_group_unhealthy
    interval            = var.target_group_interval
    timeout             = var.target_group_timeout
    path                = var.target_group_path
    port                = var.target_group_port
    matcher             = var.target_group_matcher
  }

  tags = {
    name = var.lb_target_group_name
  }
}

resource "aws_lb" "lb" {
  depends_on         = [aws_security_group.load_balancer_security_group, aws_db_instance.postgres_database]
  name               = var.lb_name
  internal           = var.load_balancer_internal
  load_balancer_type = var.load_balancer_type
  security_groups    = [aws_security_group.load_balancer_security_group.id]
  subnets            = data.aws_subnet_ids.subnetIDs.ids
  ip_address_type    = var.lb_ip_address_type

  tags = {
    Environment = var.profile
    Name        = var.lb_name
  }
}

resource "aws_lb_listener" "load_balancer_listener" {
  depends_on        = [aws_lb_target_group.target_group_load_balancer, aws_lb.lb]
  load_balancer_arn = aws_lb.lb.arn
  port              = var.lb_listener_port
  protocol          = var.lb_listener_protocol
  default_action {
    type             = var.lb_listener_default_type
    target_group_arn = aws_lb_target_group.target_group_load_balancer.arn
  }
}





