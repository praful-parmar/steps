#---- /loadbalancing/main.tf


resource "aws_lb" "my_lb" {
  name = "my-lb"
  #load_balancer_type = ""
  security_groups = [var.lb_sg]
  subnets         = var.lb_subnet
  idle_timeout    = 400
}

resource "aws_lb_target_group" "lb_tg" {
  name     = "my-lb-tf-${substr(uuid(), 0, 3)}"
  port     = var.tg_port
  protocol = var.tg_protocol
  vpc_id   = var.vpc_id
  lifecycle {
    ignore_changes        = [name]
    create_before_destroy = true
  }
  health_check {
    healthy_threshold   = var.lb_healthy_thresold
    unhealthy_threshold = var.lb_unhealthy_threshold
    timeout             = var.lb_timeout
    interval            = var.lb_interval
  }
}

resource "aws_lb_listener" "lb_listerner" {
  load_balancer_arn = aws_lb.my_lb.arn
  port              = var.lb_listener_port
  protocol          = var.ln_listener_protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_tg.arn
  }

}