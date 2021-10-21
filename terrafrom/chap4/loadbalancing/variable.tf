#   /loadbalancing/variable.tf 
variable "lb_sg" {

}

variable "lb_subnet" {

}

variable "tg_port" {}
variable "tg_protocol" {}
variable "vpc_id" {}
variable "lb_healthy_thresold" {}
variable "lb_unhealthy_threshold" {}
variable "lb_timeout" {}
variable "lb_interval" {}
variable "lb_listener_port" {}
variable "ln_listener_protocol" {}
