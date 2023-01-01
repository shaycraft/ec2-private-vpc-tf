locals {
  default_acl_ingress = [
    {
      protocol   = "tcp"
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 22
      to_port    = 22
    },
    {
      protocol   = "tcp"
      rule_no    = 101
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 443
      to_port    = 443
    },
    {
      protocol   = "tcp"
      rule_no    = 102
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 80
      to_port    = 80
    }
  ]

  default_acl_egress = [
    {
      protocol   = -1
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 0
      to_port    = 0
    }
  ]
}