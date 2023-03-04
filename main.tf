data "aws_availability_zones" "azs" {}

data "aws_ami" "ubuntu_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-kinetic-22.10-amd64-server-*"]
  }

  # canonical ubuntu id
  owners = ["099720109477"]
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
  single_nat_gateway           = true

  manage_default_network_acl    = false
  public_dedicated_network_acl  = true
  private_dedicated_network_acl = true

  public_inbound_acl_rules   = concat(local.default_inbound, local.inbound.public, local.inbound.private)
  public_outbound_acl_rules  = local.default_outbound
  private_inbound_acl_rules  = concat(local.default_inbound, local.inbound.private)
  private_outbound_acl_rules = local.default_outbound
}

resource "aws_key_pair" "terraform_workspace_var_key" {
  key_name   = "terraform_workspace_var_key"
  public_key = var.ssh_key_public
}

resource "aws_instance" "nginx" {
  ami           = data.aws_ami.ubuntu_ami.id
  instance_type = "t2.micro"
  key_name      = "terraform_workspace_var_key"
  tags = {
    Name = "nginx ubuntu terraform"
  }
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = module.security_groups.ids

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = var.ssh_key_private
    timeout     = "4m"
  }

  provisioner "remote-exec" {
    inline = [
      # see https://serverfault.com/questions/478461/how-to-install-packages-with-apt-without-user-interaction
      "sudo apt-get update && sudo apt-get -y install nginx",
      "sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj '/C=US'"
    ]
  }
}

resource "aws_instance" "wordpress" {
  ami           = var.ami
  instance_type = "t2.micro"
  tags = {
    Name = "wordpress ec2 terraform"
  }
  subnet_id              = module.vpc.private_subnets[0]
  vpc_security_group_ids = module.security_groups.ids
}

module "security_groups" {
  source      = "./modules/security_groups"
  vpc         = module.vpc.vpc_id
  allow_ports = [22, 80, 443]
}

