#  /compute/variable.tf

variable "instance_count" {}
variable "instance_type" {}
variable "public_sg" {}
variable "public_subnet" {}
variable "volume_size" {}
variable "key_name" {}
variable "public_key_path" {}

variable "user_data_path" {}
variable "db_endpoint" {}
variable "db_name" {}
variable "db_username" {}
variable "db_pass" {}
variable "lb_target_group_arn" {}

variable "tg_port" {}