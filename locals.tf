locals {
  default_acl_ingress = [
    {
      protocol    = "tcp"
      rule_number = 100
      rule_action = "allow"
      cidr_block  = "0.0.0.0/0"
      from_port   = 22
      to_port     = 22
    },
    {
      protocol    = "tcp"
      rule_number = 101
      rule_action = "allow"
      cidr_block  = "0.0.0.0/0"
      from_port   = 443
      to_port     = 443
    },
    {
      protocol    = "tcp"
      rule_number = 102
      rule_action = "allow"
      cidr_block  = "0.0.0.0/0"
      from_port   = 80
      to_port     = 80
    }
  ]

  default_acl_egress = [
    {
      protocol    = -1
      rule_number = 100
      rule_action = "allow"
      cidr_block  = "0.0.0.0/0"
      from_port   = 0
      to_port     = 0
    }
  ]
}