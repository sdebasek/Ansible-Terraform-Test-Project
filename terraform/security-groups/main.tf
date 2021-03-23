variable "az_list" {
    type = list(string)
    default = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

resource "aws_vpc" "mainvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Main_VPC"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.mainvpc.id
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.mainvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

   tags = {
    Name = "main"
  }
}

resource "aws_main_route_table_association" "rt_vpc_a" {
  vpc_id         = aws_vpc.mainvpc.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.mainvpc.id
  cidr_block = "10.0.${count.index + 1}.0/24"
  count = length(var.az_list)
  availability_zone = var.az_list[count.index]
  tags = {
    Name = "Subnet_Main_${count.index + 1}"
  }
}

resource "aws_security_group" "sg_ssh" {
  name = "AllowSSH"
  vpc_id = aws_vpc.mainvpc.id

  ingress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 22
    to_port = 22
    protocol = "TCP"
  }

  egress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
}

resource "aws_security_group" "sg_http" {
  name = "AllowHTTP"
  vpc_id = aws_vpc.mainvpc.id

  ingress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 80
    to_port = 80
    protocol = "TCP"
  }

  egress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
}

resource "aws_security_group" "sg_mysql" {
  name = "AllowMySQL"
  vpc_id = aws_vpc.mainvpc.id

  dynamic "ingress" {
    for_each = var.webserver_ips
    iterator = this_ip
    content {
      cidr_blocks = [ "${this_ip.value}/32" ]
      from_port = 3306
      to_port = 3306
      protocol = "TCP"
    }
    
  }

  egress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
}