resource "aws_network_acl" "acl" {
  vpc_id = aws_vpc.challenge.id
  subnet_ids = [
  aws_subnet.public_subnet_1.id,
  aws_subnet.public_subnet_2.id,
  ]


  tags = {
    Name = "${local.project_name}-acl"
  }
}


resource "aws_network_acl_rule" "ingress_100" {
  network_acl_id = aws_network_acl.acl.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 22
  to_port        = 22
}

resource "aws_network_acl_rule" "ingress_101" {
  network_acl_id = aws_network_acl.acl.id
  rule_number    = 101
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "ingress_102" {
  network_acl_id = aws_network_acl.acl.id
  rule_number    = 102
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "ingress_103" {
  network_acl_id = aws_network_acl.acl.id
  rule_number    = 103
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "ingress_104" {
  network_acl_id = aws_network_acl.acl.id
  rule_number    = 104
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 8888
  to_port        = 8888
}


resource "aws_network_acl_rule" "egress_100" {
  network_acl_id = aws_network_acl.acl.id
  rule_number    = 100
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "egress_101" {
  network_acl_id = aws_network_acl.acl.id
  rule_number    = 101
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "egress_102" {
  network_acl_id = aws_network_acl.acl.id
  rule_number    = 102
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}