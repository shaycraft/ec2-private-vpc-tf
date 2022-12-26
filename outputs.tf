output "vpc" {
  value = module.vpc.vpc_id
}

output "subnet_public_cidr" {
  value = module.vpc.public_subnets_cidr_blocks
}

output "subnet_public_ids" {
  value = module.vpc.public_subnets
}

output "wordpress_dns" {
  value = aws_instance.wordpress.public_dns
}

output "wordpress_ip_public" {
  value = aws_instance.wordpress.public_ip
}

output "wordpress_ip_private" {
  value = aws_instance.wordpress.private_ip
}