variable "ec2-sg" {
  type = list(string)
}

variable "vpc-name" {
  type = string
}

variable "subnets" {
  type = list(string)
}