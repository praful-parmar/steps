# /comput/output.tf

output "instances" {
  value     = aws_instance.my_node[*]
  sensitive = true
}

output "instance_port" {
  value = aws_lb_target_group_attachment.my_tg_attachment[0].port
}