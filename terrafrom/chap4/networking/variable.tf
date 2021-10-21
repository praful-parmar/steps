#####./networking/output.tf#####

variable "my_cidr" {
  type = string
}

variable "public_cidrs" {
  type = list(any)
}

variable "private_cidrs" {
  type = list(any)
}
variable "public_sub_cnt" {
  type = number
}
variable "private_sub_cnt" {
  type = number
}
variable "total_subnet" {
  type = number
}

variable "access_ip" {
  type = string
}

variable "security_groups" {}

variable "db_subnet" {
  type = bool
}