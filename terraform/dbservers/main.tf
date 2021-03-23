resource "aws_instance" "dbserver" {
  ami = "ami-0de9f803fcac87f46"
  associate_public_ip_address = true
  instance_type = "t2.micro"
  vpc_security_group_ids = var.ec2-sg
  key_name = var.key-pair
  subnet_id = var.subnets[0]
  tags = {
    "Name" = "Database"
    "Task" = "dbserver"
  }
}