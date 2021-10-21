output "lb_target_group_arn" {
  value = aws_lb_target_group.lb_tg.arn
}

output "load_balancer_dns_name" {
  value = aws_lb.my_lb.dns_name
}