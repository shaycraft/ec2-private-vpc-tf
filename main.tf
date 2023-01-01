data "aws_availability_zones" "azs" {}

data "aws_ami" "ubuntu_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  # canonical ubuntu id
  owners = ["099720109477"]
}

data "local_file" "ssh_key" {
  filename = "${path.module}/ssh-key.pub"
}

resource "aws_key_pair" "terraform_local_key_file" {
  key_name   = "terraform_local_key_file"
  public_key = data.local_file.ssh_key.content
}


module "vpc" {
  source                       = "terraform-aws-modules/vpc/aws"
  cidr                         = var.vpc_cidr
  public_subnets               = var.public_subnets
  private_subnets              = var.private_subnets
  azs                          = data.aws_availability_zones.azs.names
  tags                         = { "Name" = "terraform vpc" }
  create_database_subnet_group = false
  public_subnet_tags           = { "Name" = "public subnet terraform" }
  private_subnet_tags          = { "Name" = "private subnet terraform" }
  enable_dns_hostnames         = true
  enable_nat_gateway           = true
  default_network_acl_egress = [
    {
      protocol   = -1
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 0
      to_port    = 0
    }
  ]
  default_network_acl_ingress = [
    {
      protocol   = -1
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 0
      to_port    = 0
  }]

}

resource "aws_instance" "nginx" {
  depends_on    = [data.local_file.ssh_key]
  ami           = data.aws_ami.ubuntu_ami.id
  instance_type = "t2.micro"
  key_name      = "terraform_local_key_file"
  tags = {
    Name = "nginx ubuntu terraform"
  }
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.main.id]

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = data.local_file.ssh_key
    timeout     = "4m"
  }
}

resource "aws_instance" "wordpress" {
  ami           = var.ami
  instance_type = "t2.micro"
  tags = {
    Name = "wordpress ec2 terraform"
  }
  subnet_id              = module.vpc.private_subnets[0]
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
