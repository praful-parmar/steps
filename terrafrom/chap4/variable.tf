#####/root/variable.tf#####

variable "region" {
  default = "us-east-2"
}
variable "access_ip" {
  type    = string
  default = "0.0.0.0/0" #i dont know why this is not accessiible from terraform.tfvars
}

variable "db_name" {
  type = string
  #default   = "db"
  sensitive = true
}
variable "db_username" {
  type = string
  #default   = "admin"
  sensitive = true
}
variable "db_password" {
  type = string
  #default   = "password"
  sensitive = true
}