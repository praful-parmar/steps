######root/local.tf######

locals {
  cidr = "10.0.0.0/16"
}

locals {
  security_groups = {
    public = {
      name        = "public_sg"
      description = "this security gtoup belongs to public"
      ingress = {
        ssh = {
          cidr     = [var.access_ip]
          from     = 22
          to       = 22
          protocol = "tcp"
        }
        http = {
          cidr     = [var.access_ip]
          from     = 80
          to       = 80
          protocol = "tcp"
        }
        nginx = {
          cidr     = [var.access_ip]
          from     = 8000
          to       = 8000
          protocol = "tcp"
        }
      }
    }

    RDS = {
      name        = "rds_database"
      description = "this security group belongs to rds"
      ingress = {
        mysql = {
          cidr     = [local.cidr]
          from     = 3306
          to       = 3306
          protocol = "tcp"
        }
      }
    }
  }
}