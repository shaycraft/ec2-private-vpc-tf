resource "aws_security_group" "main_egress" {
  vpc_id = var.vpc
  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = "default egress all rule"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = -1
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
}

resource "aws_security_group" "main_ingress" {
  count  = length(var.allow_ports)
  vpc_id = var.vpc

  ingress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = "Port # ${var.allow_ports[count.index]}"
      from_port        = var.allow_ports[count.index]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = var.allow_ports[count.index]
    }
  ]
}