#####./networking/output.tf#####

output "vpc_id" {
  value = aws_vpc.main.id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.my_db_subnet.*.id
}

output "db_security_group" {
  value = [aws_security_group.sg["RDS"].id]
}

output "public_sg" {
  value = aws_security_group.sg["public"].id
}

output "public_subnet" {
  value = aws_subnet.my_public_subnet.*.id
}

output "tg_vpc_id" {
  value = aws_vpc.main.id
}