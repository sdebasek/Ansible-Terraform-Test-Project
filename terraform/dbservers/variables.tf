variable "ec2-sg" {
  type = list(string)
}

variable "key-pair" {
  type = string
}

variable "subnets" {
  type = list(string)
}