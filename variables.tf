variable "region" {
  type    = string
  default = "us-west-2"
}

variable "ami" {
  description = "ami id for wordpress server"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block of VPC"
  type        = string
}

variable "public_subnets" {
  description = "Public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnets"
  type        = list(string)
}

variable "ssh_key_name" {
  description = "ssh key name"
  type        = string
  default     = "terraform_ec2-private-vpc-poc"
}