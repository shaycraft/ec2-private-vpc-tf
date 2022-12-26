data "aws_availability_zones" "azs" {}

module "vpc" {
  source                       = "terraform-aws-modules/vpc/aws"
  cidr                         = "10.0.0.0/16"
  public_subnets               = ["10.0.1.0/24"]
  azs                          = data.aws_availability_zones.azs.names
  tags                         = { "Name" = "terraform vpc" }
  create_database_subnet_group = false
  public_subnet_tags           = { "Name" = "public subnet terraform" }
}