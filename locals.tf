locals {

  default_inbound = [{
    protocol    = "tcp"
    rule_number = 50
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 1024
    to_port     = 65535
  }]

  default_outbound = [{
    protocol    = -1
    rule_number = 55
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 0
    to_port     = 0
  }]

  inbound = {
    public = [
      {
        protocol    = -1
        rule_number = 100
        rule_action = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 22
        to_port     = 22
      }
    ]

    private = [
      {
        protocol    = -1
        rule_number = 101
        rule_action = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 80
        to_port     = 80
      },
      {
        protocol    = -1
        rule_number = 102
        rule_action = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 443
        to_port     = 443
      }
    ]
  }
}