output "ids" {
  value = concat([aws_security_group.main_egress.id], aws_security_group.main_ingress[*].id)
}