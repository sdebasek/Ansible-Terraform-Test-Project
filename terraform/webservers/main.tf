resource "aws_instance" "webserver" {
  ami = "ami-0de9f803fcac87f46"
  associate_public_ip_address = true
  instance_type = "t2.micro"
  count = var.no_of_vms
  vpc_security_group_ids = var.ec2-sg
  subnet_id = var.subnets[count.index]
  key_name = var.key-pair
  tags = {
    "Name" = "Webserver-${count.index}",
    "Task" = "webserver"
  }
}

resource "aws_lb_target_group_attachment" "test" {
  count = length(aws_instance.webserver)
  target_group_arn = var.tg_arn
  target_id        = aws_instance.webserver[count.index].id
  port             = 80
}