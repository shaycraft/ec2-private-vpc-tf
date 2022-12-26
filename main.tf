data "aws_availability_zones" "azs" {}

module "vpc" {
  source                       = "terraform-aws-modules/vpc/aws"
  cidr                         = var.vpc_cidr
  public_subnets               = var.public_subnets
  azs                          = data.aws_availability_zones.azs.names
  tags                         = { "Name" = "terraform vpc" }
  create_database_subnet_group = false
  public_subnet_tags           = { "Name" = "public subnet terraform" }
  enable_dns_hostnames         = true
}

resource "aws_instance" "wordpress" {
  ami           = var.ami
  instance_type = "t2.micro"
  tags = {
    Name = "wordpress ec2 terraform"
  }
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.main.id]
}

resource "aws_security_group" "main" {
  vpc_id = module.vpc.vpc_id
  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
  ingress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
}
