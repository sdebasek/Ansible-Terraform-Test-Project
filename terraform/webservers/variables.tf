variable "ec2-sg" {
  type = list(string)
}

variable "key-pair" {
  type = string
}

variable "no_of_vms" {
  type = number
}


variable "subnets" {
  type = list(string)
}

variable "tg_arn" {
  type = string
}