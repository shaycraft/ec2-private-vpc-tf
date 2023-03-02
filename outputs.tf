output "vpc" {
  value = module.vpc.vpc_id
}

output "subnet_public_cidr" {
  value = module.vpc.public_subnets_cidr_blocks
}

output "subnet_public_ids" {
  value = module.vpc.public_subnets
}

output "subnet_private_cidr" {
  value = module.vpc.private_subnets_cidr_blocks
}

output "subnet_private_ids" {
  value = module.vpc.private_subnets
}

output "wordpress_ip_private" {
  value = aws_instance.wordpress.private_ip
}

output "nginx_public_ip" {
  value = aws_instance.nginx.public_ip
}

output "nginx_private_ip" {
  value = aws_instance.nginx.private_ip
}

output "nginx_public_dns" {
  value = aws_instance.nginx.public_dns
}

output "private_ssh_key" {
  value     = tls_private_key.private_key.private_key_pem
  sensitive = true
}

output "public_ssh_key" {
  value = tls_private_key.private_key.public_key_pem
}

output "public_ssh_key_openssh" {
  value = tls_private_key.private_key.public_key_openssh
}

