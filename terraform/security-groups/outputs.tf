output "ssh_security_group_name" {
  value = aws_security_group.sg_ssh.name
}

output "mysql_security_group_name" {
  value = aws_security_group.sg_mysql.name
}

output "http_security_group_name" {
  value = aws_security_group.sg_http.name
}

output "ssh_security_group_id" {
  value = aws_security_group.sg_ssh.id
}

output "mysql_security_group_id" {
  value = aws_security_group.sg_mysql.id
}

output "http_security_group_id" {
  value = aws_security_group.sg_http.id
}

output "vpc_name" {
  value = aws_vpc.mainvpc.id
}

output "subnets" {
  value = aws_subnet.subnet.*.id
}