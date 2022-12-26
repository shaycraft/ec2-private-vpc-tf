output "vpc" {
  value = module.vpc.vpc_id
}

output "subnet_public_cidr" {
  value = module.vpc.public_subnets_cidr_blocks
}

output "subnet_public_ids" {
  value = module.vpc.public_subnets
}