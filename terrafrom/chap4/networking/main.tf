#####./networking/main.tf#####

# data "aws_availability_zone" "available" {
#   state                  = "available"
#   all_availability_zones = true
#   name = "us-east-1a"
#   #names attribute of this is not found
# }

resource "random_shuffle" "az_list" {
  input        = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"] #data.aws_availability_zone.names
  result_count = var.total_subnet
}

resource "random_string" "random" {
  min_numeric = 1
  length      = 2
}

resource "aws_vpc" "main" {
  cidr_block           = var.my_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true



  tags = {
    Name = "my_vpc-${random_string.random.id}"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "my_public_subnet" {
  count                   = var.public_sub_cnt
  vpc_id                  = aws_vpc.main.id
  availability_zone       = random_shuffle.az_list.result[count.index]
  cidr_block              = var.public_cidrs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "my-public-sub-${count.index + 1}"
  }
}

resource "aws_route_table_association" "public_assoc" {
  count          = var.public_sub_cnt
  subnet_id      = aws_subnet.my_public_subnet.*.id[count.index]
  route_table_id = aws_route_table.public_rt.id
}



resource "aws_subnet" "my_private_subnet" {
  count                   = var.private_sub_cnt
  vpc_id                  = aws_vpc.main.id
  availability_zone       = random_shuffle.az_list.result[count.index]
  cidr_block              = var.private_cidrs[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "my-private-sub-${count.index + 1}"
  }

}

resource "aws_internet_gateway" "my_gateway" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "my_internet_gateway"
  }
}


resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "my-public_rt"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_gateway.id
}

resource "aws_default_route_table" "private_rt" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  tags = {
    Name = "my_private_rt"
  }
}

resource "aws_security_group" "sg" {
  for_each = var.security_groups

  name        = each.value.name
  description = each.value.description
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = each.value.ingress
    content {
      cidr_blocks = ingress.value.cidr
      from_port   = ingress.value.from
      to_port     = ingress.value.to
      protocol    = ingress.value.protocol
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = each.value.name
  }

}


resource "aws_db_subnet_group" "my_db_subnet" {
  count      = var.db_subnet ? 1 : 0
  name       = "my_db_subnet"
  subnet_ids = aws_subnet.my_private_subnet.*.id

  tags = {
    Name = "my_db_subnet"
  }

}