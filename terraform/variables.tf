variable "aws_region" {
type = string
default = "ca-central-1"
}


variable "vpc_cidr" {
type = string
default = "10.0.0.0/16"
}


variable "public_subnet_cidr" {
type = string
default = "10.0.1.0/24"
}


variable "private_subnet_cidr" {
type = string
default = "10.0.2.0/24"
}


variable "allowed_ssh_cidr" {
type = string
description = "Your IP in CIDR format (e.g. 1.2.3.4/32)"
default = "0.0.0.0/0"
}


variable "key_name" {
type = string
default = "aviralpaliwal"
}


variable "instance_type_frontend" {
type = string
default = "t3.micro"
}


variable "instance_type_backend" {
type = string
default = "t3.micro"
}